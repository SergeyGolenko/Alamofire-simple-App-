//
//  ViewController.swift
//  Alamofire(simple App)
//
//  Created by Sergey Golenko on 26.02.2020.
//  Copyright © 2020 Sergey Golenko. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    var items : [Item] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func sendRequest(_ sender: Any) {
        
        AF.request("https://jsonplaceholder.typicode.com/photos")
        .validate()
            .responseJSON{(response) in
                switch response.result {
                case .success(let value):
                    
                    guard let arrayOfItems = value as? [[String:Any]] else {print("ОШИБКА");return}
                    print("РАБОТАЮ")
                    
                    for itm in arrayOfItems {
                        guard
                        
                        let albumId = itm["albumId"] as? Int,
                        let title = itm["title"] as? String,
                        let url = itm["url"] as? String,
                        let id = itm["id"] as? Int
                        
                            else {print("проверка перед append");return}
                        
                        let posts = Item(albumID: albumId, id: id, title: title, url: url)
                        self.items.append(posts)
                        self.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    print("ОШИБКА - \(error)")
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        configureCell(cell: cell, for: indexPath)
        return cell
    }
    
    private func configureCell(cell:CustomTableViewCell,for indexPath:IndexPath){
        let item = items[indexPath.row]
        cell.idLabel.text = "\(item.id)"
        cell.albumIdLabel.text = "\(item.albumID)"
        cell.titleLabel.text = item.title
        cell.urlLabel.text = item.url
    }
    
    
}

