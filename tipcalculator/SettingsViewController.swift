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
    var lastSelected : Int = 0
  
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var defTipSelect: UISegmentedControl!
    @IBOutlet weak var lowSlideLabel: UILabel!
    @IBOutlet weak var midSlideLabel: UILabel!
    @IBOutlet weak var maxSlideLabel: UILabel!
    @IBOutlet weak var lowSlider: UISlider!
    @IBOutlet weak var midSlider: UISlider!
    @IBOutlet weak var maxSlider: UISlider!
    
    override func viewDidLoad() {
        println("lifcycle: (Settings) viewDidLoad")
        super.viewDidLoad()
        lastSelected = getDefTip()
        println("lastselected \(lastSelected)")
        defTipSelect.selectedSegmentIndex = lastSelected
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("lifecycle:(Settings) view will disappear")
        // if tip rate selection changed, invalidate saved index by setting it to -1
        if( defTipSelect.selectedSegmentIndex != lastSelected){
            println("reset")
            defaults.setInteger(-1, forKey: "savedSegIndex")
            defaults.setInteger(defTipSelect.selectedSegmentIndex, forKey: "def_tip_index")
            defaults.synchronize()
        }
       
        println("(Settings) saved \(defTipSelect.selectedSegmentIndex)")
        
    }
    
    override func viewWillAppear(animated: Bool){
        
        self.view.alpha = 0
        UIView.animateWithDuration(0.7, animations: {
            self.view.alpha = 1
        })
        var colorTheme = defaults.stringForKey("tipColorTheme") ?? "Light"
        if (colorTheme == "Light"){
            themeSwitch.on = false
            lightColorTheme()
        }
        else{
            themeSwitch.on = true
            darkColorTheme()
        }
        themeLabel.text = "\(colorTheme) theme"    }
    
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
        self.view.backgroundColor = UIColor(red:1.0,green:1.0,blue:1.0,alpha:1.0);
        themeLabel.textColor = UIColor.blackColor()
        label1.textColor = UIColor.blackColor()
        label2.textColor = UIColor.blackColor()
        
    }
    
    func darkColorTheme(){
       
        self.view.backgroundColor = UIColor(red:0.1,green:0.1,blue:0.1,alpha:1.0);
        themeLabel.textColor = UIColor.whiteColor()
        label1.textColor = UIColor.whiteColor()
        label2.textColor = UIColor.whiteColor()
       
    }
   
    @IBAction func onSwitch(sender: UISwitch) {
        print("switched")
        if(themeSwitch.on){
            defaults.setObject("Dark",forKey: "tipColorTheme")
            defaults.synchronize()
            themeLabel.text="Dark Theme"
            darkColorTheme()
        }
        else{
            defaults.setObject("Light",forKey: "tipColorTheme")
            defaults.synchronize()
            themeLabel.text="Light Theme"
            lightColorTheme()        }
    }
    
    
    @IBAction func lowSlideChanged(sender: UISlider) {
        let sliderVal = String(Int(lowSlider.value*100))
        lowSlideLabel.text = sliderVal + "%"
        if(lowSlider.value >= midSlider.value){
            midSlider.value = lowSlider.value
            midSlideLabel.text = String(Int(midSlider.value*100)) + "%"
        }
        if(lowSlider.value >= maxSlider.value){
            maxSlider.value = lowSlider.value
            maxSlideLabel.text = String(Int(maxSlider.value*100)) + "%"
        }
    }
    @IBAction func midSlideChanged(sender: UISlider) {
        let sliderVal = String(Int(midSlider.value*100))
        midSlideLabel.text = sliderVal + "%"
        if(midSlider.value >= maxSlider.value){
            maxSlider.value = midSlider.value
            maxSlideLabel.text = String(Int(maxSlider.value*100)) + "%"
        }
        if(midSlider.value <= lowSlider.value){
            lowSlider.value = midSlider.value
            lowSlideLabel.text = String(Int(lowSlider.value*100)) + "%"
        }
    }
    @IBAction func maxSlideChanged(sender: UISlider) {
        let sliderVal = String(Int(maxSlider.value*100))
        maxSlideLabel.text = sliderVal + "%"
        if(maxSlider.value <= midSlider.value){
            midSlider.value = maxSlider.value
            midSlideLabel.text = String(Int(midSlider.value*100)) + "%"
        }
        if(maxSlider.value <= lowSlider.value){
            lowSlider.value = maxSlider.value
            lowSlideLabel.text = String(Int(lowSlider.value*100)) + "%"
        }
    }
}