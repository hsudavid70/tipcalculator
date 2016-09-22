//
//  ViewController.swift
//  tipcalculator
//
//  Created by davidhsu on 9/21/16.
//  Copyright (c) 2016 davidhsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
  
    
    @IBOutlet weak var tipSelect: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      
   
        
       
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // get stored/default tip percent and update 
        tipSelect.selectedSegmentIndex = getDefTip()
        update_bill()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
  
    @IBAction func calcTip(sender: AnyObject) {
       
       update_bill()
        
    }

    func update_bill(){
        let tipPercents = [0.10,0.20,0.30]
        // The String->Double conversion for Swift 1.2
        let bill = (billField.text as NSString).doubleValue
        let tip = bill * tipPercents[tipSelect.selectedSegmentIndex];
        let total = bill + tip;
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
 
}

