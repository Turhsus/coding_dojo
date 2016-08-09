//
//  ViewController.swift
//  core_data_lecture
//
//  Created by Pariece Mckinney on 7/18/16.
//  Copyright © 2016 pariece. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButtonPressed(sender: AnyObject) {
        let text = inputField.text!
        inputField.text = ""
        
        let entity = NSEntityDescription.entityForName("People", inManagedObjectContext: context)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context)
        
        person.setValue(text, forKey: "name")
        
        do{
            try context.save()
        }catch let error as NSError {
            print(error)
        }
    }

}

