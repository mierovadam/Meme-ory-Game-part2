//
//  ViewController.swift
//  Memeory Game
//
//  Created by Adam Mierov on 28/04/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var triesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var allButtons: Array<UIButton>! // = [UIButton]?
    
    
    var mode:Int!               //0 for easy 4x4, 1 for hard 4x5
    var timer : Timer!
    
    var tries = 0
    var timeInSeconds = 0                //secs
    var images:[Int]!            //array position is card position, number for image name
    
    var firstButtonTag:Int!
    var secondButtonTag:Int!
    
    var firstImage:Int!
    var secondImage:Int!
    
    var cardsLeft:Int! //depends on the mode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mode = 0;
        
        initGameVars()   //shuffle images array array
        startTimer()
        
        
    }
    
    func initGameVars(){
        if mode==0 {
            images = Array(1...8) + Array(1...8);    //8 cards, each card appears twice
            cardsLeft = 8
            
            //HIDE BOTTOM ROW BUTTONS IF MODE "EASY"
            for i in Range(17...20){
                let tmpButton = view.viewWithTag(i) as? UIButton
                tmpButton?.isHidden = true
            }
            
        }else{
            images = Array(1...10) + Array(1...10);    //10 cards
            cardsLeft = 10
        }
        images.shuffle()    //shuffle the "deck".
    }
        
    @IBAction func newRound(sender: UIButton) {
        //FIRST CARD PICK
        if firstButtonTag==nil {
            firstImage = images[sender.tag - 1]
            firstButtonTag = sender.tag
            sender.setBackgroundImage(UIImage(named: String(firstImage)+".png" ), for: UIControl.State.normal)
            
            sender.isUserInteractionEnabled = false;    //disable first card so cannot be picked twice
            
        //SECOND CARD PICK
        } else {
            secondImage = images[sender.tag - 1]
            secondButtonTag = sender.tag
            sender.setBackgroundImage(UIImage(named: String(secondImage)+".png" ), for: UIControl.State.normal)
            
            sender.isUserInteractionEnabled = false;
            disableButtons()

            let tmpButton = view.viewWithTag(firstButtonTag) as? UIButton
            
            //DELAY AFTER SECOND CARD PICK SO CARDS CAN BE SEEN
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                //Player chose identical cards
                if self.firstImage == self.secondImage {
                    tmpButton?.isUserInteractionEnabled = false;
                    sender.isUserInteractionEnabled = false;
                    
                    //Remove the two buttons from allButtons array so they wont be re-enabled to be pressed again
                    if let idx = self.allButtons.firstIndex(where: { $0 === sender }) {
                        self.allButtons.remove(at: idx)
                    }
                    if let idx = self.allButtons.firstIndex(where: { $0 === tmpButton }) {
                        self.allButtons.remove(at: idx)
                    }
                    
                    self.cardsLeft -= 1
                    
                    //IF NO MORE CARDS LEFT TO BE FOUND, STOP THE TIMER
                    if self.cardsLeft == 0 {
                        self.stopTimer()
                    }
                    
                } else {
                    //RENABLE CARDS
                    tmpButton?.isUserInteractionEnabled = true;
                    sender.isUserInteractionEnabled = true;

                    //tmpButton?.isEnabled = true
                    //sender.isEnabled = true
                    //TURN CARDS AROUND
                    tmpButton?.setBackgroundImage(UIImage(named: "dog_wallpaper.png" ), for: UIControl.State.normal)
                    sender.setBackgroundImage(UIImage(named: "dog_wallpaper.png" ), for: UIControl.State.normal)

                    self.tries += 1
                    self.triesLabel.text = String(self.tries)
                    
                }
                self.enableButtons()
                self.resetPick()
            }
            
        }
    }
    
    
    // MARK:Timer Functions
    func stopTimer(){
        timer.invalidate()
        timer = Timer()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeInSeconds += 1
        let seconds: Int = timeInSeconds % 60
        let minutes: Int = (timeInSeconds / 60) % 60
        
        timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func resetPick(){
        firstImage      = nil
        secondImage     = nil
        firstButtonTag  = nil
        secondButtonTag = nil
    }
    
    func disableButtons(){
        for button in allButtons{
            button.isUserInteractionEnabled = false;
        }
    }
    
    func enableButtons(){
        for button in allButtons{
            button.isUserInteractionEnabled = true;
        }
    }
    
    func endOfGame() {
        //code
    }
    
    func playAgain() {
        //code
    }
    
    @IBAction func exit() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
