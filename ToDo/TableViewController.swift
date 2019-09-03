//
//  TableViewController.swift
//  ToDo
//
//  Created by Chaehyeon Lee on 02/09/2019.
//  Copyright © 2019  Chaehyeon Lee. All rights reserved.
//

import UIKit

struct MyTask {
    var taskName : String
    var deadline : String
}


var names = ["h", "e", "l", "l"]
var dates = ["2033", "343", "123", "@353"]

class TableViewController: UITableViewController {
    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        self.tvListView.dataSource = self
        self.tvListView.delegate = self
        self.tvListView.rowHeight = 66
        self.tvListView.contentInset = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0);

        
    }
    
    // 뷰가 전환될때 호출되는 함수
    override func viewWillAppear(_ animated: Bool) {
        self.tvListView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell

        // Configure the cell...
        cell.tfTaskName?.text = names[(indexPath as NSIndexPath).row]
        
        
        
        // deadline 없애깅.
        if dates[(indexPath as NSIndexPath).row] == "Deadline : None" {
            cell.tfDeadline.isHidden = true;
        }else {
            cell.tfDeadline?.text = dates[(indexPath as NSIndexPath).row]
        }
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    
    
//    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            names.remove(at: (indexPath as NSIndexPath).row)
            dates.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let taskNameToMove = names[(fromIndexPath as NSIndexPath).row]
        let dateToMove = dates[(fromIndexPath as NSIndexPath).row]
        print(fromIndexPath)
        names.remove(at : (fromIndexPath as NSIndexPath).row)
        dates.remove(at : (fromIndexPath as NSIndexPath).row)
        names.insert(taskNameToMove, at : (to as NSIndexPath).row)
        dates.insert(dateToMove, at : (to as NSIndexPath).row)
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)

            
            let detailView = segue.destination as! DetailViewController
            let myTask = MyTask(taskName: names[((indexPath as NSIndexPath?)?.row)!] ,deadline: dates[((indexPath as NSIndexPath?)?.row)!])
            detailView.receiveItem(myTask)


        }
    }
 

}