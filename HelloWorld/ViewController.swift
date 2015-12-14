//
//  ViewController.swift
//  HelloWorld
//
//  Created by Daniel Vaquero on 24/3/15.
//  Copyright (c) 2015 daniel.vaquero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var aButton:       UIButton!
    
    var labelTotalMoves:  UILabel!
    var totalMoves:       Int!
    
//    let bgColor  = UIColor(red: 254/255, green: 250/255, blue: 246/255, alpha: 1)
    let bgColor  = UIColor(red: 242/255, green: 255/255, blue: 255/255, alpha: 1)
    
    var totalCols:Int = 3
    var totalRows:Int = 3
    
    let levelEasy:Int   = 1
    let levelMedium:Int = 2
    let levelHard:Int   = 3
    
    var bubblesContainerView:UIView!
    var myBubbleCollection: BubbleCollection!
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.drawBubbleCollection()
        
        /*if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            println("landscape")
        } else {
            println("portraight")
        }*/
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.bgColor

        self.generateInitialViewElements()
        
        self.initBubbleCollection()
        self.drawStatusLabels()
        self.createBubblesContainerView()
        self.drawBubbleCollection()
    }
    
    func initBubbleCollection() {
        self.totalMoves = 0
        self.myBubbleCollection = BubbleCollection(cols: self.totalCols, rows: self.totalRows, initX: 0, initY: 0)
        self.myBubbleCollection.createBubbleCollection()
    }
    
    func createBubblesContainerView () {
        self.bubblesContainerView = UIView(frame: CGRectMake(0, 0, 0, 0))
        self.bubblesContainerView.backgroundColor = self.bgColor
        self.view.addSubview(self.bubblesContainerView)
    }
    
    func removeDynamicView () {
        self.bubblesContainerView.removeFromSuperview()
    }
    
    func drawBubbleCollection() {
        var myButton:UIButton
        let bubbleCollection = self.myBubbleCollection.getCollection()
        let firstBubble = bubbleCollection[0][0]
        let totalWith = CGFloat(self.totalCols) * (firstBubble.width + 1)
        let totalHeigth = CGFloat(self.totalRows) * (firstBubble.height + 1)
        
        let screenWidth = UIScreen.mainScreen().bounds.width

        // Adjust view to bubble collection content
        self.bubblesContainerView.frame = CGRectMake(0, 0, totalWith, totalHeigth)
        self.bubblesContainerView.center = self.view.center
        
        // Draw [row][bubbles]
        for bubbleRow in bubbleCollection {
            for bubble in bubbleRow {
                
                myButton = bubble.myButton
                myButton.addTarget(self, action: "bubblePressed:", forControlEvents: UIControlEvents.TouchUpInside)
                // Position outside of screen
                myButton.frame.origin.x = screenWidth
                self.bubblesContainerView.addSubview(myButton)
                // Animate to the bubble position
                UIView.animateWithDuration(0.5, animations: {
                    myButton.frame.origin.x = bubble.axisX
                })
            }
        }

    }
    
    func generateInitialViewElements() {
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        self.labelTotalMoves = UILabel(frame: CGRectMake(CGFloat(screenWidth - 200), 30, 170, 21))
        self.labelTotalMoves.textColor = UIColor(red: 28.0/100, green: 183.0/255, blue: 235.0/205, alpha: 1.0)
        self.labelTotalMoves.font = UIFont(name: self.labelTotalMoves.font.fontName, size: 15)
        self.labelTotalMoves.textAlignment = NSTextAlignment.Right
        self.view.addSubview(self.labelTotalMoves)
    }
    
    func drawStatusLabels() {
//        var totalBubbles:Int = self.totalCols * self.totalRows
//        self.labelTotalMoves.text = "\(self.myBubbleCollection.totalOn) / \(totalBubbles)"
        self.labelTotalMoves.text = "Total moves: \(self.totalMoves)"
    }
    
    func bubblePressed(sender:UIButton!) {
        var buttonPressed:UIButton = sender
        var bubbleIndex = buttonPressed.tag
        var bubble:Bubble? = self.myBubbleCollection.getBubbleByIndex(bubbleIndex)
        
        self.totalMoves = self.totalMoves + 1
        self.myBubbleCollection.toggleAroundBubble(bubble!)
        self.drawStatusLabels()
        
        if self.theGameIsOver() == true {
            self.showWinMessage()
        }
    }
    
    func showWinMessage() {
        let alertController = UIAlertController(title: "CONGRATULATIONS!", message: "You win! :D", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func theGameIsOver() -> Bool {
        if self.myBubbleCollection.totalOn < 1 {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func newGame(sender: UIButton) {
        let buttonPressed:UIButton = sender
        
        switch buttonPressed.tag {
            case self.levelEasy:
                self.totalCols = 3
                self.totalRows = 3
            case self.levelMedium:
                self.totalCols = 4
                self.totalRows = 4
            case self.levelHard:
                self.totalCols = 5
                self.totalRows = 5
            default:
                self.totalCols = 3
                self.totalRows = 3
        }
        
        // Reset viewContainer and generate/draw collection
        self.removeDynamicView()
        self.createBubblesContainerView()
        self.initBubbleCollection()
        self.drawBubbleCollection()
        self.drawStatusLabels()
    }
    
}

