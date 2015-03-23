//
//  ResultsViewController.swift
//  OnlineStore
//
//  Created by uppersky04 on 3/23/15.
//  Copyright (c) 2015 uppersky. All rights reserved.
//

import UIKit
import CoreData
class ResultsViewController: UIViewController {
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var brands = [NSManagedObject]()
    var clothings = [NSManagedObject]()
    
    var brandsFound : [String] = []
    var clothingsFound : [String] = []
    
    var queryString : String = ""
    
    var indexBrand = 0
    var indexClothing = 0
    
     @IBOutlet weak var table: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

       // println(queryString)
        
        brandFetchRequest()
        clothingFetchRequest()
        exploreQuery()
        
        table.reloadData()
        
        /*
        let brand = NSEntityDescription.insertNewObjectForEntityForName("Clothing", inManagedObjectContext: managedObjectContext) as Clothing
        
        brand.setValue("Dresses", forKey: "name")
        
        managedObjectContext.save(nil)
        */
        
        /*
        clothingFetchRequest()
        
        for obj in clothings{
        let clothing = obj as Clothing
        println(clothing.name)
        }
        
        brandFetchRequest()
        
        for obj in brands{
        let brand = obj as Brand
        println(brand.name)
        }
        */

        
        
        // Do any additional setup after loading the view.
    }
    
    func exploreQuery(){
        
        //loop for brands
        for obj in brands{
            let brandString = (obj as Brand).name
            let range = queryString.rangeOfString(brandString.lowercaseString)
            if  range != nil {
                brandsFound.append(brandString)
                queryString.removeRange(range!)
            }
        }
        
        //loop for clothings
        for obj in clothings{
            let clothingString = (obj as Clothing).name
            let range = queryString.rangeOfString(clothingString.lowercaseString)
            if range != nil {
                clothingsFound.append(clothingString)
                queryString.removeRange(range!)
            }
        }

    }
    
    func brandFetchRequest() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Brand")
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            brands = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    func clothingFetchRequest() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Clothing")
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            clothings = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows : Int = 0
        if section == 0 {
            rows = brandsFound.count
        }
        else
            if section == 1{
                rows = clothingsFound.count
            }
            else {
                rows = 1
        }
        
        return rows
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell  = tableView.dequeueReusableCellWithIdentifier("cellResult") as UITableViewCell!
        
        if indexPath.section == 0 {
            cell.textLabel!.text = brandsFound[indexBrand]
            indexBrand++
        }
        else
            if indexPath.section == 1{
                cell.textLabel!.text = clothingsFound[indexClothing]
                indexClothing++
            }
            else {
                cell.textLabel!.text = queryString
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
        
        
        var label : UILabel = UILabel()
        
        if section == 0 {
            label.text = "Brand"
            label.backgroundColor = UIColor.grayColor()
        }
        else
            if section == 1{
                label.text = "Clothing Type"
                label.backgroundColor = UIColor.grayColor()
            }
            else {
                label.text = "Result Query"
                label.backgroundColor = UIColor.grayColor()
        }
        
     
        return label
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    /*func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var tittle : String = ""
        if section == 0 {
            tittle = "Brand"
        }
        else
            if section == 1{
                tittle = "Clothing Type"
            }
            else {
                tittle = "Result Query"
        }
        
        return tittle
    }
    */
}
