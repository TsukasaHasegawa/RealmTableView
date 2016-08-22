//
//  InputViewController.swift
//  RealmTableView
//
//  Created by Tsukasa Hasegawa on 2016/07/31.
//  Copyright © 2016年 Tsukasa Hasegawa. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.frame.size.height = 30
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        let newTodo = ToDo()
        
        // textFieldに入力したデータをnewTodoのtitleに代入
        newTodo.title = titleTextField.text!
        
        // 上記で代入したテキストデータを永続化
        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(newTodo)
                print("ToDo Saved")
            })
        }catch{
            print("Save is Faild")
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
