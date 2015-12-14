import Foundation
import UIKit

class Bubble {
    
    var width:  CGFloat
    var height: CGFloat
    var axisX:  CGFloat
    var axisY:  CGFloat
    
    let statusOFF: Int = 0
    let statusON:  Int = 1
    
    var status: Int
    var row:    Int
    var col:    Int

//    let onUIColor  = UIColor(red: 28.0/100, green: 183.0/255, blue: 235.0/205, alpha: 1.0)
//    let offUIColor = UIColor(red: 169.0/255, green: 199.0/255, blue: 86.0/255, alpha: 1.0)

//    let onUIColor  = UIColor(red: 209/255, green: 232/255, blue: 238/255, alpha: 1.0)
//    let offUIColor = UIColor(red: 214/255, green: 223/255, blue: 226/255, alpha: 1.0)
    
        let onUIColor  = UIColor(red: 162/255, green: 212/255, blue: 205/255, alpha: 1.0)
        let offUIColor = UIColor(red: 208/255, green: 241/255, blue: 242/255, alpha: 1.0)

    
    var myButton: UIButton!
    
    init (axisX: CGFloat , axisY: CGFloat, width: CGFloat, height: CGFloat, row: Int, col: Int) {
        self.axisX  = axisX
        self.axisY  = axisY
        self.width  = width
        self.height = height
        self.row = row
        self.col = col
        // Status random
        self.status = Int(arc4random_uniform(2))
    }

    func construct (numberOfBubble: Int) {
        var newButton:UIButton
        
        newButton = UIButton(frame: CGRectMake(self.axisX, self.axisY, self.width, self.height))
        // UIButton(frame: CGRectMake(self.view.bounds.origin.x + (self.view.bounds.width * 0.325), self.view.bounds.origin.y + (self.view.bounds.height * 0.8), self.view.bounds.origin.x + (self.view.bounds.width * 0.35), self.view.bounds.origin.y + (self.view.bounds.height * 0.05)))
        // Redondas
        newButton.layer.cornerRadius = height / 2
        // Cuadrados
//                newButton.layer.cornerRadius = 2

        if (self.status == self.statusOFF) {
            newButton.backgroundColor = offUIColor
        } else {
            newButton.backgroundColor = onUIColor
        }

        // Index in bubbleCollection
        newButton.tag = numberOfBubble;
        
        self.myButton = newButton
    }

    func toggle () {
        let nextColor:UIColor
        if self.status == self.statusON {
            nextColor = offUIColor
            self.status = self.statusOFF
        } else {
            nextColor = onUIColor
            self.status = self.statusON
        }
        // Change color with transition
        UIView.animateWithDuration(0.2, animations: {
            self.myButton.backgroundColor = nextColor
        })

    }
      
    func getBubbleButton () -> UIButton{
        return self.myButton
    }

}
