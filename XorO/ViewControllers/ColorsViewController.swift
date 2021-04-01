//
//  ColorsViewController.swift
//  XorO
//
//  Created by Armen Shahvaladyan on 11/10/19.
//  Copyright © 2019 Armen Shahvaladyan. All rights reserved.
//

import UIKit
import Localize_Swift

class ColorsViewController: UIViewController {
    var selectedColor: UIColor
    var index:IndexPath?
    var onSelectColor: ((_ color: UIColor) -> Void)?
    
    let tabelView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.backgroundColor = .clear
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...colors.count - 1 {
            let color = colors[i]
            if color == selectedColor {
                index = IndexPath(row: i, section: 0)
                break
            }
        }
        
        
        setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        title = "ColorKey".localized()
        
        
        
    }
    
    init(_ color: UIColor) {
        self.selectedColor = color
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setup() {
        self.title = "Choose color"
        self.view.addSubview(tabelView)
        tabelView.frame = self.view.bounds
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.register(UINib(nibName: "ColorCell", bundle: nil), forCellReuseIdentifier: ColorCell.reuseIdentifier)
        
    }
}

extension ColorsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.reuseIdentifier, for: indexPath) as? ColorCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
            
        }
        
        
        let color = colors[indexPath.row]
        cell.colorView.backgroundColor = color
        //        if selectedColor == color { index = indexPath }
        cell.accessoryType = index == indexPath ? .checkmark : .none
        
        return cell
    }
}

extension ColorsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        tableView.deselectRow(at: indexPath, animated: false)
    //        guard let cell = tableView.cellForRow(at: indexPath) else {
    //            return
    //        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        if index != nil {
            let cell = tableView.cellForRow(at: index!)
            cell?.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        index = indexPath
        
        onSelectColor?(colors[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
