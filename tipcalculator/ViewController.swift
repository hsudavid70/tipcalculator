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
    let numFormatter = NSNumberFormatter()
    let tipPercents = [10,20,30]
    
    @IBOutlet weak var tipSelect: UISegmentedControl!
    @IBOutlet weak var tipStepper: UIStepper!
    @IBOutlet weak var peopleStepper: UIStepper!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipValLabel: UILabel!
    @IBOutlet weak var totalValLabel: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var keyInputField: UITextField!
    @IBOutlet weak var tipRateLabel: UILabel!
    @IBOutlet weak var numPeopleLabel: UILabel!
    @IBOutlet weak var tipRateValLabel: UILabel!
    @IBOutlet weak var numPeopleValLabel: UILabel!
    
    override func viewDidLoad() {
        let timeviewDidLoad = Int(NSDate().timeIntervalSince1970)
        println("lifecycle: (Main) viewDidLoad \(timeviewDidLoad)")
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "localeChanged:",
            name: NSCurrentLocaleDidChangeNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "willTerminate:",
            name: UIApplicationWillTerminateNotification,
            object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
        numFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        numFormatter.locale = NSLocale.currentLocale()
        //numFormatter.minimumFractionDigits = 2
        numFormatter.maximumFractionDigits = 2
        // set first responder for bill
        self.keyInputField.becomeFirstResponder()
        let lastStoppedTime = getStoppedTime()
        
        let savedSegIndex = getSavedTip()
       
        // check for invalidated segmentselect index
        if(savedSegIndex != -1){
             println("restored saved segment select")
             tipSelect.selectedSegmentIndex = savedSegIndex
        }
        
        // check for stored app stopped time and 10 min interval
        if(lastStoppedTime != 0 && (timeviewDidLoad - lastStoppedTime) < 600){
            // load from saved state
            keyInputField.text = defaults.stringForKey("savedInput")
            tipStepper.value = defaults.doubleForKey("tipStepperVal")
            peopleStepper.value = defaults.doubleForKey("peopleStepperVal")
            tipRateValLabel.text = Int(tipStepper.value).description + "%"
            numPeopleValLabel.text = Int(peopleStepper.value).description
            
        }
        else{
            // init everything to 0
            billField.text = numFormatter.stringFromNumber(0)
            tipValLabel.text = numFormatter.stringFromNumber(0)
            totalValLabel.text = numFormatter.stringFromNumber(0)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        println("lifecycle: viewWillAppear")
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
        
        let savedIndex = getSavedTip()
        /* index is set to -1 to indicate reset or indeterminate state.  The default selection will be loaded */
        if(savedIndex != -1){
         
            tipSelect.selectedSegmentIndex = getSavedTip()
           
        }
        else{
            // rest from settings
            tipSelect.selectedSegmentIndex = getDefTip()
            tipRateValLabel.text = String(tipPercents[tipSelect.selectedSegmentIndex]) + "%"
            tipStepper.value = Double(tipPercents[tipSelect.selectedSegmentIndex])
        }
        update_bill()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("lifecycle:(Main) view will disappear")
        
        defaults.setInteger(tipSelect.selectedSegmentIndex, forKey: "savedSegIndex")
        defaults.synchronize()
        println("(Main) saved \(tipSelect.selectedSegmentIndex)")
       
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
    
    // get stopped time with check
    
    func getStoppedTime()->Int{
        if(checkKey("lastStoppedTime")){
            return defaults.objectForKey("lastStoppedTime") as! Int
        }
        else{
            return 0
        }
    }
    
    // get saved segment select index
    
    func getSavedTip()->Int{
        
        if(checkKey("savedSegIndex")){
            return defaults.objectForKey("savedSegIndex") as! Int
        }
        else{
            defaults.setInteger(-1, forKey: "savedSegIndex")
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
        tipRateLabel.textColor = UIColor.blackColor()
        tipRateValLabel.textColor = UIColor.blackColor()
        numPeopleLabel.textColor = UIColor.blackColor()
        numPeopleValLabel.textColor = UIColor.blackColor()
       
        
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
        tipRateLabel.textColor = UIColor.whiteColor()
        tipRateValLabel.textColor = UIColor.whiteColor()
        numPeopleLabel.textColor = UIColor.whiteColor()
        numPeopleValLabel.textColor = UIColor.whiteColor()
    }
    
    func update_bill(){
        
        
        
        // The String->Double conversion for Swift 1.2
        let keyInputVal = (keyInputField.text as NSString).doubleValue
        let tip = keyInputVal/100 * tipStepper.value/100
        let total = keyInputVal/100 + tip;

        billField.text = numFormatter.stringFromNumber(keyInputVal/100)
        tipValLabel.text = numFormatter.stringFromNumber(tip/Double(peopleStepper.value))
        totalValLabel.text = numFormatter.stringFromNumber(total/Double(peopleStepper.value))
        
        tipLabel.text = Int(peopleStepper.value) > 1 ? "Tip/pers." : "Tip"
        totalLabel.text = Int(peopleStepper.value) > 1 ? "Total/pers." : "Total"
        
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        //view.endEditing(true)
    }
  
    @IBAction func calcTip(sender: AnyObject) {
       
        if (count(keyInputField.text) > 10) {
            keyInputField.deleteBackward()
        }
        update_bill()
     
    }
    
    @IBAction func tipStepperChanged(sender: UIStepper) {
        tipRateValLabel.text = Int(sender.value).description + "%"
        update_bill()
    }
    
    @IBAction func peopleStepperChanged(sender: UIStepper) {
        numPeopleValLabel.text = Int(sender.value).description
        update_bill()
    }
    
    @IBAction func segValueChanged(sender: UISegmentedControl) {
      
        tipRateValLabel.text = String(tipPercents[tipSelect.selectedSegmentIndex]) + "%"
        tipStepper.value = Double(tipPercents[tipSelect.selectedSegmentIndex])
        update_bill()
        
    }
    // life cycle event handler

    func localeChanged(notification: NSNotification) {
        println("locale changed")
        numFormatter.locale = NSLocale.currentLocale()
        update_bill()
    }
  
    
    func willTerminate(notification: NSNotification){
         // get time in unix epoch time to the nearest seconds
         let timeTerminate = Int(NSDate().timeIntervalSince1970)
         println("lifecycle: willTerminate \(timeTerminate)")
         // save the termination time, user input, selected index
         defaults.setInteger(timeTerminate, forKey: "lastStoppedTime")
         defaults.setObject(keyInputField.text, forKey:"savedInput")
         defaults.setInteger(tipSelect.selectedSegmentIndex, forKey: "savedSegIndex")
         defaults.setDouble(tipStepper.value, forKey: "tipStepperVal")
         defaults.setDouble(peopleStepper.value, forKey: "peopleStepperVal")
         defaults.synchronize()
        
    }
}