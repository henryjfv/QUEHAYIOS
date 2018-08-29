//
//  ViewController.swift
//  Que Hay
//
//  Created by Henry Fernandez on 17/08/18.
//  Copyright © 2018 Henry Fernandez. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    var ref: DatabaseReference!
    var handle: DatabaseHandle!
    var mList:[Event] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! ViewControllerTableViewCell
        //        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.lblTitle?.text = mList[indexPath.row].title
        cell.lblCategory?.text = mList[indexPath.row].category
        cell.lblPlace?.text = mList[indexPath.row].dateEvent
        cell.lblPrice?.text = mList[indexPath.row].price
        if let urlStr = URL(string: mList[indexPath.row].urlImage){
            do{
                let data = try Data(contentsOf: urlStr)
                if(data != nil ){
                cell.myImage?.image = UIImage(data: data)
                cell.myImage?.layer.masksToBounds = true
                }
            }catch let err {
                print(err.localizedDescription)
            }
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        handle = ref?.child("events").observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    if let data = snap.value as? [String:AnyObject]{
                        let name = data["name"] as? String
                        let image = data["image"] as? String
                        let dateStr = data["date"] as? String
                        let category = data["categoria"] as? String
                        let price = data["price"] as? String
                        self.mList.append(Event(title: name!,urlImage: image!,category: category!,place: "",price: price!,dateEvent:dateStr!))
                    }
                }
                self.myTableView.reloadData()

            }
//            if let item = snapshot.key as? String
//            {
//                self.mList.append(item)
//                self.myTableView.reloadData()
//            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

