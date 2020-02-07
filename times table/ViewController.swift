//
//  ViewController.swift
//  Times Table
//
//  Created by Michael Zhou on 19/10/2018.
//  Copyright © 2018 Michael Zhou. All rights reserved.
//

// Imported library
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    // Initialise empty array to store the times table
    var array:[String] = []
    
    // Outlet property defined for the user text field
    @IBOutlet weak var inputField: UITextField!
    
    // Action macro property upon pressing Go button
    @IBAction func goBtn(_ sender: Any) {
        // Hides keyboard upon pressing on button
        self.inputField.resignFirstResponder()
        
        // Clears out previous appended timetable inputs
        array.removeAll()
        
        // Variable to hold the user's choice of multiplier in the text field
        guard let yourNumberInString = inputField.text else { return }

        // Converts it into an integer
        let multiplier = Int(yourNumberInString)
        
        // If statment to check that as long as the text field is not blank
        if (yourNumberInString != "")
        {
        // The for loop will iterate from 1 to 20 to show all the timetables user requested
        for index in 1...20
            {
                // Formula to calculate the product
                let product = index * multiplier!
                // Variable to hold the output for each cell of which contain one line of the multiplication table for that number
                let outputStr = (String(index) + " X " + (yourNumberInString) + " = " + String(product))
                // Appends the values for each cell into an array
                array.append(outputStr)
            }
        }
        // Refreshes content of table
        myTable.reloadData()
        
        // Clears out the input field when button is pressed as the user prepares to enter a new guess
        self.inputField.text = nil
    }
    
    // Outlet property created for the table
    @IBOutlet weak var myTable: UITableView!
    
    // Returns the number of rows in the given section of the table view
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return array.count
    }
    
    // Constructs each table view cell that will be displayed
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = String(array[indexPath.row])
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the table as its own delegate
        self.myTable.delegate = self
        // Sets the user text field as its own delegate
        inputField.delegate = self
        
        // Displays the numeric keyboard to request the user's guess
        // To toggle virtual keyboard appearance on simulator you may need to use the shortcut cmd + k
        inputField.keyboardType = UIKeyboardType.numberPad
    }
    
    // Ensures text field can take only contain in digits from 0-9 as input, anything else is rejected
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == inputField {
            let digitsInStr = "1234567890"
            let allowedCharacterSet = CharacterSet(charactersIn: digitsInStr)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let digits = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            return digits
        }
        return true
    }

    // Dismisses keyboard upon touching outside textfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputField.resignFirstResponder()
    }
}

