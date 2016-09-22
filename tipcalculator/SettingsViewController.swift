//
//  SettingsViewController.swift
//  tipcalculator
//
//  Created by davidhsu on 9/21/16.
//  Copyright (c) 2016 davidhsu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    

    @IBOutlet weak var defTipSelect: UISegmentedControl!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defTipSelect.selectedSegmentIndex = getDefTip()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        // save selected tip
        defaults.setInteger(defTipSelect.selectedSegmentIndex, forKey: "def_tip_index")
        defaults.synchronize()
    }
    // check if preference keys exist, if not , set default value to 10 %
    
    func getDefTip()->Int{
        
        if(checkKey("def_tip_index")){
            return defaults.objectForKey("def_tip_index") as! Int
        }
        else{
            defaults.setInteger(0, forKey: "def_tip_index")
            defaults.synchronize()
            return 0
        }
    }
    
    // check if key exists
    func checkKey(userKey:String)->Bool{
        return defaults.objectForKey(userKey) != nil
    }
    
   
  

}
