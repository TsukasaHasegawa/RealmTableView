//
//  TableViewController.swift
//  RealmTableView
//
//  Created by Tsukasa Hasegawa on 2016/07/31.
//  Copyright © 2016年 Tsukasa Hasegawa. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
    
    var todoItem: Results<ToDo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 永続化されているデータを取りだす
        do{
            let realm = try Realm()
            todoItem = realm.objects(ToDo)
            tableView.reloadData()
        }catch{
            
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        return todoItem.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexpath: NSIndexPath)->UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        let object = todoItem[indexpath.row]
        
        cell.textLabel?.text = object.title
        return cell
    }
    
    // TableViewのCellの削除を行った際に、Realmに保存したデータを削除する
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if(editingStyle == UITableViewCellEditingStyle.Delete) {
            do{
                let realm = try Realm()
                try realm.write {
                    realm.delete(self.todoItem[indexPath.row])
                }
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }catch{
            }
            tableView.reloadData()
            print(todoItem)
        }
    }



}
