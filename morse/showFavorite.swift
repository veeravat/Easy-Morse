//
//  showFavorite.swift
//  morse
//
//  Created by TuyMove on 11/29/17.
//  Copyright © 2017 ZeroP. All rights reserved.
//

import UIKit

class showFavorite: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate {
    

    @IBOutlet weak var tableData: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let DB = SQLiteDB.shared
        DB.openDB()
        let str:String = "SELECT * FROM favorite"
        let data = DB.query(sql: str)
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: "contentRow") as! UITableViewCell
        let DB = SQLiteDB.shared
        DB.openDB()
        let str:String = "SELECT * FROM favorite"
        let data = DB.query(sql: str)
        dataCell.textLabel?.text = (data[indexPath.row]["text"] as! String)
        
        return dataCell
    }
    
    // Override to support conditional editing of the table view.
    // This only needs to be implemented if you are going to be returning NO
    // for some items. By default, all items are editable.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let dataCell = tableView.dequeueReusableCell(withIdentifier: "contentRow") as! UITableViewCell
            let DB = SQLiteDB.shared
            DB.openDB()
            var str:String = "SELECT * FROM favorite"
            let data = DB.query(sql: str)
            str = "DELETE FROM favorite WHERE text = '\((data[indexPath.row]["text"] as! String))'"
            DB.query(sql: str)
            tableData.reloadData()
        }else{
            print(editingStyle)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: "contentRow") as! UITableViewCell
        let DB = SQLiteDB.shared
        DB.openDB()
        let str:String = "SELECT * FROM favorite"
        let data = DB.query(sql: str)
        print("Selected row \(indexPath.row) Data is \(data[indexPath.row]["text"] as! String)")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "viewFavorite") as! viewFavorite
//        let vc = self.tabBarController as! MorseGen
//        let viewCon = self.tabBarController?.viewControllers
//        let navController = viewCon![0] as! UINavigationController
//        navController.pushViewController(profileViewController!, animated: true)
//
//        self.tabBarController?.selectedIndex = 0
        vc.TXT_inputR = data[indexPath.row]["text"] as! String
        vc.TXT_outputR = data[indexPath.row]["code"] as! String
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // During startup (-viewDidLoad or in storyboard) do:
        tableData.allowsMultipleSelectionDuringEditing = false;
        
//        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableData.reloadData()
    }

}
