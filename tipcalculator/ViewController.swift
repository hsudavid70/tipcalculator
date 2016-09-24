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
    var numFormatter = NSNumberFormatter()
 
    
    @IBOutlet weak var tipSelect: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipValLabel: UILabel!
    @IBOutlet weak var totalValLabel: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var keyInputField: UITextField!
    
    override func viewDidLoad() {
        println("lifecycle: viewDidLoad")
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "localeChanged:",
            name: NSCurrentLocaleDidChangeNotification,
            object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
        numFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        numFormatter.locale = NSLocale.currentLocale()
        //numFormatter.minimumFractionDigits = 2
        numFormatter.maximumFractionDigits = 2
        // set first responder for bill
        self.keyInputField.becomeFirstResponder()
        billField.text = numFormatter.stringFromNumber(0)
        tipValLabel.text = numFormatter.stringFromNumber(0)
        totalValLabel.text = numFormatter.stringFromNumber(0)
    }
    
    override func viewWillAppear(animated: Bool) {
        println("lifecycle: viewDidLoad")
        super.viewWillAppear(animated)
        // load locale
       
        // get stored/default tip percent and update
        self.billField.alpha = 0
        self.tipSelect.alpha = 0
        
        UIView.animateWithDuration(0.7, animations: {
            // This causes first view to fade in and second view to fade out
            
            self.billField.alpha = 1
            self.tipSelect.alpha = 1
          
            
        })
        
        var colorTheme = defaults.stringForKey("tipColorTheme") ?? "Light"
        if (colorTheme == "Light"){
           
            lightColorTheme()
        }
        else{
       
            darkColorTheme()
        }
        
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
  
    
    func lightColorTheme(){
        self.view.backgroundColor = UIColor(red:1.0,green:1.0,blue:1.0,alpha:1.0)
        billField.backgroundColor = UIColor.whiteColor()
        billField.textColor = UIColor.blackColor()
        billField.tintColor = UIColor.blackColor()
        billField.layer.borderWidth = 1
        billField.layer.borderColor = UIColor.blackColor().CGColor
        divider.backgroundColor = UIColor.blackColor()
        tipValLabel.textColor = UIColor.blackColor()
        totalValLabel.textColor = UIColor.blackColor()
        billLabel.textColor = UIColor.blackColor()
        tipLabel.textColor = UIColor.blackColor()
        totalLabel.textColor = UIColor.blackColor()
       
        
    }
    
    func darkColorTheme(){
 
        self.view.backgroundColor = UIColor(red:0.1,green:0.1,blue:0.1,alpha:1.0)
        billField.backgroundColor = UIColor.blackColor()
        billField.textColor = UIColor.whiteColor()
        billField.tintColor = UIColor.whiteColor()
        billField.layer.borderWidth = 1
        billField.layer.borderColor = UIColor.whiteColor().CGColor
        divider.backgroundColor = UIColor.whiteColor()
        tipValLabel.textColor = UIColor.whiteColor()
        totalValLabel.textColor = UIColor.whiteColor()
        billLabel.textColor = UIColor.whiteColor()
        tipLabel.textColor = UIColor.whiteColor()
        totalLabel.textColor = UIColor.whiteColor()
        
    }
    
    func update_bill(){
        
        let tipPercents = [0.10,0.20,0.30]
      
       
        // The String->Double conversion for Swift 1.2
     
        let keyInputVal = (keyInputField.text as NSString).doubleValue
       
        //println(numFormatter.stringFromNumber(bill/100))
      
        /*
        if(){
            bill = 0
        }else{
            bill = numFormatter.numberFromString(billField.text) as Double
        }
        */
        let tip = keyInputVal/100 * tipPercents[tipSelect.selectedSegmentIndex]
        let total = keyInputVal/100 + tip;
        
//        tipValLabel.text = String(format: "$%.2f", tip)
//        totalValLabel.text = String(format: "$%.2f", total)
        billField.text = numFormatter.stringFromNumber(keyInputVal/100)
    
        tipValLabel.text = numFormatter.stringFromNumber(tip)
        totalValLabel.text = numFormatter.stringFromNumber(total)
        
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        //view.endEditing(true)
    }
  
    @IBAction func calcTip(sender: AnyObject) {
       
        if (count(keyInputField.text) > 10) {
            keyInputField.deleteBackward()
        }
        update_bill()
       //billField.resignFirstResponder()
    }

    func localeChanged(notification: NSNotification) {
        println("locale changed")
        numFormatter.locale = NSLocale.currentLocale()
        update_bill()
    }
  
   
}

