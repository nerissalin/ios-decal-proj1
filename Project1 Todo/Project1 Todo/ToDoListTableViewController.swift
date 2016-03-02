//
//  ViewController.swift
//  Project1 Todo
//
//  Created by Everest Shi on 2/29/16.
//  Copyright © 2016 Nerissa Lin. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    //1. MODEL CREATE CUSTOM CLASS WITH A SOMETHING THATS A TODO LIST ITEM
    //2. Reload data to call the everything again to update
    
    var model: NSMutableArray = []
    var countcompleted: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Only called once so maybe initialize it here
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToToDoListTableViewController(segue: UIStoryboardSegue){
        self.expiredChecked()
        //self.tableView.reloadData()

    }
    
    @IBAction func unwindToToDoListTableViewControllerAfterAdd(segue: UIStoryboardSegue){
        let source: AddToDoItemViewController = segue.sourceViewController as! AddToDoItemViewController
        if source.notempty {
            let item: ToDoItem = source.toDoItem!
            self.model.addObject(item)
        }
        self.expiredChecked()
        //self.tableView.reloadData()

    }
    
    override func tableView(tableView:UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //model.removeAtIndex(indexPath.row)
            model .removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell", forIndexPath: indexPath) as! ToDoListTableViewCell
        let todoitem: ToDoItem = self.model.objectAtIndex(indexPath.row) as! ToDoItem
        cell.toDoItemTextLabel.text = todoitem.itemDesc as String
        if todoitem.completed{
            cell.accessoryType = .Checkmark
            //completed.append((item: todoitem, date: NSDate()));
            todoitem.date = NSDate()
        } else {
            cell.accessoryType = .None
            //for index in 0 ... (completed.count-1){
            //    if (completed[index].item == todoitem){
            //        completed.removeAtIndex(index)
            //    }
            //}
        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let tappedItem: ToDoItem = self.model.objectAtIndex(indexPath.row) as! ToDoItem
        tappedItem.completed = !tappedItem.completed
        tableView.reloadData()
    }
    
    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: NSDate(), options: []).hour
    }
    
    func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: NSDate(), options: []).minute
    }
    
    func expiredChecked(){
        if (model.count > 0){
            for i in 0...(model.count - 1){
                let todoitem: ToDoItem = self.model.objectAtIndex(i) as! ToDoItem
                if todoitem.completed{
                    let x = hoursFrom(todoitem.date)
                    if (x >= 24){
                        model.removeObjectAtIndex(i);
                        expiredChecked();
                        break;
                    }
                }
                
            }
        }
        
        self.tableView.reloadData()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (model.count > 0){
            self.countcompleted = 0
            for i in 0 ... (model.count - 1) {
                let todoitem: ToDoItem = self.model.objectAtIndex(i) as! ToDoItem
                if todoitem.completed{
                    self.countcompleted = self.countcompleted + 1
                }
            }
        }
        
        if (segue.identifier == "Stats") {
            let nav = segue.destinationViewController as! UINavigationController
            let viewController = nav.topViewController as! ToDoListStatsViewController
            
            viewController.Completed = self.countcompleted
        }
        
        
    }
    
    

    
}

