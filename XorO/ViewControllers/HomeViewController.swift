//
//  HomeViewController.swift
//  XorO
//
//  Created by Armen Shahvaladyan on 11/10/19.
//  Copyright © 2019 Armen Shahvaladyan. All rights reserved.
//

import UIKit
import Localize_Swift


class HomeViewController: UIViewController {
    
    var index: IndexPath!
    var transperentView = UIView()
    var tableView = UITableView()
    let hight: CGFloat = 180
    var language = ["English","Russian","Armenian"]
    let codes = ["English": "en", "Russian": "ru", "Armenian": "hy"]
    
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var xImageView: UIImageView!
    @IBOutlet weak var oImageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    
    
    @IBOutlet weak var imageTicTacToe: UIImageView! {
        didSet {
            imageTicTacToe.layer.cornerRadius = 25
            imageTicTacToe.layer.masksToBounds = true
            let borderColor = UIColor.white
            imageTicTacToe.layer.borderColor = borderColor.cgColor
            imageTicTacToe.layer.borderWidth = 5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
        label.text = "Сlick on the button ⓘ and at the top"
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        index = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        
        let window = UIApplication.shared.keyWindow
        transperentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        transperentView.frame = self.view.frame
        window?.addSubview(transperentView)
        
        
        let screenSize = UIScreen.main.bounds.size
        tableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: hight)
        tableView.backgroundColor = .gray
        window?.addSubview(tableView)
        
        
        
    let tapGesture = UITapGestureRecognizer(target: self, action:#selector(onClickTransperentView))
    transperentView.addGestureRecognizer(tapGesture)
        
        transperentView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.transperentView.alpha = 0.5
            self.tableView.frame = CGRect(x: 0, y: screenSize.height - self.hight, width: screenSize.width, height: self.hight)
        }, completion: nil)
        
        
        
    }
    
    @objc func onClickTransperentView() {
        
        let screenSize = UIScreen.main.bounds.size
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.transperentView.alpha = 0
            self.tableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.hight)
        }, completion: nil)
        transperentView.alpha = 0
        title = "HomeKey".localized()
        label.text = "Homelabelkey".localized()
        playButton.setTitle("PlayKey".localized(), for: .normal)
    }
    
    
    
    func setup() {
       
        playButton.isEnabled = false
        
        xImageView.image = #imageLiteral(resourceName: "x").withRenderingMode(.alwaysTemplate)
        xImageView.tintColor = .blue
        
        oImageView.image = #imageLiteral(resourceName: "o").withRenderingMode(.alwaysTemplate)
        oImageView.tintColor = .red
        
        let xTap = UITapGestureRecognizer(target: self, action: #selector(handleX))
        xImageView.addGestureRecognizer(xTap)
        
        let oTap = UITapGestureRecognizer(target: self, action: #selector(handleO))
        oImageView.addGestureRecognizer(oTap)
    }
    
    @objc func handleX() {
        let vc = ColorsViewController(xImageView.tintColor)
        vc.onSelectColor = { color in
            self.xImageView.tintColor = color
            self.playButton.isEnabled = true
            self.checkSelectedColor()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    @objc func handleO() {
        let vc = ColorsViewController(oImageView.tintColor)
        vc.onSelectColor = { color in
            self.oImageView.tintColor = color
            self.playButton.isEnabled = true
            self.checkSelectedColor()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkSelectedColor() {
        if oImageView.tintColor == xImageView.tintColor {
            let alert = UIAlertController(title: "Attention".localized(), message: "X and O colors the same ".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func play(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc: PlayViewController = segue.destination as? PlayViewController ?? PlayViewController.init()
        
        vc.xColor = xImageView.tintColor
        vc.oColor = oImageView.tintColor
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return language.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell else {fatalError("Unable to deque cell")}
        cell.lbl.text = language[indexPath.row]
        cell.settingImage.image = UIImage(named: language[indexPath.row])!
        cell.backgroundColor = .gray
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let code = codes[language[indexPath.row]] else { return }
            Localize.setCurrentLanguage(code)
            print(code)
                
                
        if indexPath == index {
            let alert = UIAlertController(title: "Attention".localized(), message: "This language is already selected".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Сhoose language".localized(), style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .default, handler: {(action:UIAlertAction!) in
        self.onClickTransperentView() }))
        self.present(alert, animated: true, completion: nil)
                
        return
        }
        index = indexPath
     
        
        
        onClickTransperentView()
        
    }

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


