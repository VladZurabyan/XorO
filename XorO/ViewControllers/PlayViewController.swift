//
//  PlayViewController.swift
//  XorO
//
//  Created by Haykanush on 11/21/19.
//  Copyright © 2019 Armen Shahvaladyan. All rights reserved.
//

import UIKit
import AVFoundation
import Localize_Swift

class PlayViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 55
            imageView.layer.masksToBounds = true
            let borderColor = UIColor.darkGray
            imageView.layer.borderColor = borderColor.cgColor
            imageView.layer.borderWidth = 5
        }
    }
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.colors = [UIColor.yellow.cgColor,UIColor.systemYellow.cgColor, UIColor.green.cgColor]
        }
    }
    
    
    var musicPlayer: AVAudioPlayer?
    var time: TimeInterval = 0
    var ximage: UIImage!
    var oimage: UIImage!
    var xColor: UIColor!
    var oColor: UIColor!
    var xScore: Int = 0
    var oScore: Int = 0
    var activeplayer = 1 //cross
    var gamestate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winningcombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var isgameactive = true
    var count = 0
    var flag = 0
    
    @IBOutlet weak var musicButton: UIButton!    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var xScoreLabel: UILabel!{
        didSet {
            xScoreLabel.layer.cornerRadius = xScoreLabel.frame.size.height/2
            xScoreLabel.layer.masksToBounds = true
            
        }
    }
    
    @IBOutlet weak var oScoreLabel: UILabel!{
        didSet {
            oScoreLabel.layer.cornerRadius = oScoreLabel.frame.size.height/2
            oScoreLabel.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var whowon: UILabel! {
        didSet {
            whowon.layer.cornerRadius = whowon.frame.size.height/2
            whowon.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.layer.shadowOffset = CGSize(width: 0, height: 5)
            button.layer.shadowOpacity = 0.5
            button.layer.shadowRadius = 5
        }
    }
    
    @IBOutlet weak var resetButton: UIButton! {
        didSet {
            resetButton.layer.shadowOffset = CGSize(width: 0, height: 5)
            resetButton.layer.shadowOpacity = 1
            resetButton.layer.shadowRadius = 10
            
        }
    }
    
    @IBAction func action1(_ sender: UIButton) {
        isgameactive = true
        gamestate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        for j in 1...9
        {
            let button = view.viewWithTag(j) as! UIButton
            button.setImage(nil, for:UIControl.State())
        }
        flag = 0
        count = 0
        resetButton.isHidden = true
    }
    
    
    
    @IBAction func action(_ sender: UIButton) {
        if gamestate[sender.tag - 1] == 0 && isgameactive == true {
            gamestate[sender.tag-1] = activeplayer
            if activeplayer == 1 {
                
                activeplayer = 2
                sender.setImage(ximage, for: .normal)
                sender.tintColor = xColor
                resetButton.isHidden = false
            } else {
                sender.setImage(oimage, for: .normal)
                sender.tintColor = oColor
                activeplayer = 1
                resetButton.isHidden = false
            }
            count = count+1
        }
        
        if flag == 0 && count == 9 {
            whowon.text = "DRAW".localized()
            whowon.isHidden = false
            button?.isHidden = false
            resetButton.isHidden = true
        }
        
        for i in winningcombinations {
            if (isgameactive == true && gamestate[i[0]] != 0 && gamestate[i[0]] == gamestate[i[1]] && gamestate[i[1]] == gamestate[i[2]]) {
                if activeplayer == 2 {
                    
                    isgameactive = false
                    whowon.isHidden = false
                    button?.isHidden = false
                    whowon.text = "CROSS WON".localized()
                    resetButton.isHidden = true
                    flag = 1
                    xScore += 1
                    xScoreLabel.text = "xScore:".localized() + "\(xScore)"
                    
                    
                }
                if activeplayer == 1 {
                    isgameactive = false
                    whowon.isHidden = false
                    button?.isHidden = false
                    whowon.text = "NOUGHT WON".localized()
                    resetButton.isHidden = true
                    flag = 1
                    oScore += 1
                    oScoreLabel.text = "oScore:".localized() + "\(oScore)"
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ximage = #imageLiteral(resourceName: "x").withRenderingMode(.alwaysTemplate)
        oimage = #imageLiteral(resourceName: "o").withRenderingMode(.alwaysTemplate)
        
        let path = Bundle.main.path(forResource: "I am Happy - AShamaluevMusic", ofType: "mp3")
        
        let url = URL(fileURLWithPath: path!)
        
        do {
            // set up the player by loading the sound file
            try musicPlayer = AVAudioPlayer(contentsOf: url)
        }
        
            // catch the error if playback fails
        catch { print("file not availalbe")}
        
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "GameTitleKey".localized()
        xScoreLabel.text = "xScoreKey".localized()
        oScoreLabel.text = "oScoreKey".localized()
        resetButton.setTitle("resetButton".localized(), for: .normal)
        button.setTitle("button".localized(), for: .normal)
    }
    
    @IBAction func actionSlider(_ sender: UISlider) {
        self.musicPlayer?.volume = self.volumeSlider.value
    }
    
    @IBAction func buttonStop(_ sender: UIButton) {
        musicPlayer?.currentTime = 0
        
       /* if musicPlayer != nil {
         musicPlayer!.stop()
         time = 0
         musicPlayer?.play()
         }*/
    }
    
    @IBAction func buttonPlay(_ sender: UIButton) {
        // play and resume
        if musicPlayer != nil{
            musicPlayer!.currentTime = time
            musicPlayer!.play()
        }
    }
    
    
    @IBAction func buttonPause(_ sender: UIButton) {
        if musicPlayer != nil {
            time = musicPlayer!.currentTime
            musicPlayer!.pause()
        }
    }
    
    @IBAction func playagain(_ sender: UIView) {
        isgameactive = true
        gamestate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        whowon.text = " "
        
        for j in 1...9 {
            let button = view.viewWithTag(j) as! UIButton
            button.setImage(nil, for:UIControl.State())
        }
        flag = 0
        count = 0
        button?.isHidden = true
        whowon.isHidden = true
        resetButton.isHidden = true
        
    }
    
    @IBAction func selectMusic() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController else { return }
        vc.onSelectMusic = { selectedMusicName in
            print(selectedMusicName)
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
