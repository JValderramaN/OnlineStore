//
//  ViewController.swift
//  OnlineStore
//
//  Created by uppersky04 on 3/23/15.
//  Copyright (c) 2015 uppersky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var textFieldQuery: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let detailVC: ResultsViewController = segue.destinationViewController as ResultsViewController
            detailVC.queryString = textFieldQuery.text.lowercaseString
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonSearch(sender: UIButton) {
        performSegueWithIdentifier("showResults", sender: self)
    }
    
        
    

}

