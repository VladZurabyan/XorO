//
//  TableViewController.swift
//  XorO
//
//  Created by ADMIN on 26/12/2019.
//  Copyright © 2019 Armen Shahvaladyan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var onSelectMusic: ((_ musicName: String) -> Void)?

    let musics = ["I am Happy - AShamaluevMusic", "Beethoven"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath) as! TableViewCell
        
        cell.images.image = UIImage.init(named: musics[indexPath.row])
        cell.label.text = musics[indexPath.row]
        cell.label.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let musicName = musics[indexPath.row]
        onSelectMusic?(musicName)
        self.navigationController?.popViewController(animated: true)
    }
}
