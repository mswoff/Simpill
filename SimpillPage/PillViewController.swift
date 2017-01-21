//
//  ViewController.swift
//  SimpillPage
//
//  Created by Mason Swofford on 4/13/16.
//  Copyright © 2016 Mason Swofford. All rights reserved.
//

import UIKit

class PillViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate  {

    // MARK: Properties
    
    @IBOutlet weak var pillNameTextField: UITextField!
    @IBOutlet weak var pillTimePicker: UIDatePicker!
    @IBOutlet weak var instructionsTextField: UITextField!
    @IBOutlet weak var pillsRemainingTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var pill: Pill?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field’s user input through delegate callbacks.
        pillNameTextField.delegate = self
        instructionsTextField.delegate = self
        pillsRemainingTextField.delegate = self
        
    
        if let pill = pill {
            navigationItem.title = pill.name
            pillNameTextField.text = pill.name
            instructionsTextField.text = pill.instructions
            pillsRemainingTextField.text = String(pill.pillsRemaining)
            pillTimePicker.date = pill.dispensionTime ?? NSDate()
            
            
        }
        
        checkValidPillName()
    }
    


 /*   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidPillName() {
        // Disable the Save button if the text field is empty.
        let text = pillNameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidPillName()
        if (textField == pillNameTextField){
            navigationItem.title = textField.text
        }
        if (textField == instructionsTextField) {
            
        }
        if (textField == pillsRemainingTextField){
            
        }
        
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddPillMode = presentingViewController is UINavigationController
        if isPresentingInAddPillMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = pillNameTextField.text ?? ""
            let instructions = instructionsTextField.text ?? ""
            let dispensionTime = pillTimePicker.date
            var pillsRemaining: Int8!
            if  pillsRemainingTextField.text != "" {
                pillsRemaining = Int8(pillsRemainingTextField.text!)!
            }
            else {
                pillsRemaining = 0
            }
            
            
            pill = Pill(name: name, instructions: instructions, dispensionTime: dispensionTime, pillsRemaining: pillsRemaining)
            
        }
    }

    // MARK: Action
    

}

