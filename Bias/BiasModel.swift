//
//  BiasModel.swift
//
//  Copyright (c) 2015 Mikael Hakman. All rights reserved.
//

import Cocoa

class BiasModel : NSObject {
    
    dynamic var recomp = true
    //
    // Physical constants
    //
    let q : Double = 1.602176e-19
    
    let k : Double = 1.3806503e-23
    
    let tabs : Double = 273.15
    //
    // Required input
    //
    dynamic var vcc : Double = 0 {
        
        didSet {
            
            self.recompute ()
        }
    }
    
    dynamic var ic : Double = 0 {
        
        didSet {
            
            self.recompute ()
        }
    }
    
    dynamic var beta : Double = 0 {
        
        didSet {
            
            self.recompute ()
        }
    }
    //
    // Optional input
    //
    dynamic var ke : Double = 0 {
        
        didSet {
            
            self.recompute ()
        }
    }
    
    dynamic var kbias : Double = 0 {
        
        didSet {
            
            self.recompute ()
        }
    }
    
    dynamic var isat : Double = 0 {
        
        didSet {
            
            self.recompute ()
        }
    }
    
    dynamic var tc : Double = 0 {
        
        didSet {
            
            self.recompute ()
        }
    }
    //
    // Computed results
    //
    dynamic var ib : Double = 0
    
    dynamic var ie : Double = 0
    
    dynamic var ibias : Double = 0
    
    dynamic var vc : Double = 0
    
    dynamic var vb : Double = 0
    
    dynamic var ve : Double = 0
    
    dynamic var vbe : Double = 0
    
    dynamic var rc : Double = 0
    
    dynamic var re : Double = 0
    
    dynamic var r1 : Double = 0
    
    dynamic var r2 : Double = 0
    //
    // Methods implementation
    //
    override init () {
        
        super.init ()
        
        self.setDefaults ()
    }
    
    func setDefaults () {
        
        self.recomp = false
        
        self.vcc = 12
        
        self.ic = 0.01
        
        self.beta = 100
        
        self.ke = 0.1
        
        self.kbias = 5
        
        self.isat = 1e-16
        
        self.tc = 25
        
        self.recomp = true
        
        self.recompute ()
    }
    
    func recompute () {
        
        if !recomp {
            
            return
        }
        
        self.compute_ib ()
        
        self.compute_ie ()
        
        self.compute_ibias ()
        
        self.compute_vc ()
        
        self.compute_rc ()
        
        self.compute_re ()
        
        self.compute_ve ()
        
        self.compute_vbe ()
        
        self.compute_vb ()
        
        self.compute_r1 ()
        
        self.compute_r2 ()
        
        
    }
    
    func compute_ib () {
        
        self.ib = self.ic / self.beta
    }
    
    func compute_ie () {
        
        self.ie = self.ic + self.ib
    }
    
    func compute_ibias () {
        
        self.ibias = self.kbias * self.ib
    }
    
    func compute_vc () {
        
        let delta : Double = (self.vcc * self.ke) / (2 * (1 + self.ke))
        
        self.vc = delta + self.vcc / 2
/*
        let num : Double = self.ic * self.vcc/2 + self.ke*self.ie*self.vcc
        
        let den : Double = self.ic + self.ke*self.ie
        
        self.vc = num/den
*/
    }
    
    func compute_rc () {
    
        self.rc = (self.vcc - self.vc) / self.ic
    }
    
    func compute_re () {
        
        self.re = self.ke * self.rc
    }
    
    func compute_ve () {
        
        self.ve = self.ie * self.re
    }
    
    func compute_vbe () {
        
        let tk : Double = self.tc + self.tabs
        
        let vt : Double = self.k * tk / self.q
        
        let x = self.ib * self.beta / self.isat + 1
        
        self.vbe = vt * log (self.ib * self.beta / self.isat + 1)
    }
    
    func compute_vb () {
        
        self.vb = self.ve + self.vbe
    }
    
    func compute_r1 () {
        
        self.r1 = (self.vcc - self.vb) / self.ibias
    }
    
    func compute_r2 () {
 /*
        let rx = self.vcc / self.ibias - self.r1
        
        let rbe = self.vbe / self.ib
        
        let invr2 = 1 / rx - 1 / (rbe + self.re)
        
        self.r2 = 1 / invr2
*/
        let ir2 : Double = self.ibias - self.ib
        
        self.r2 = self.vb/ir2
    }
}
