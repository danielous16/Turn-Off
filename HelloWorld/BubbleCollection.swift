import Foundation
import UIKit

class BubbleCollection {
    
    var width:CGFloat = 50
    var height:CGFloat = 50
    var initX:CGFloat
    var initY:CGFloat
    var cols:Int
    var rows:Int
    var totalOn:Int = 0
    var collection: [[Bubble]] = []
    
    init (cols: Int, rows: Int, initX: CGFloat, initY: CGFloat) {
        self.cols = cols
        self.rows = rows
        self.initX = initX
        self.initY = initY
    }
    
    func createBubbleCollection () {
        var axisX:CGFloat = initX
        var axisY:CGFloat = initY
        var myBubble:Bubble
        var numberOfBubble:Int = 0
        var arrayRow: [Bubble]
        let margin:CGFloat = 1
        
        for row in 0..<self.rows {
            arrayRow = []
            for col in 0..<self.cols {
                myBubble = Bubble(axisX: axisX, axisY: axisY, width: self.width, height: self.height, row: row, col: col)
                myBubble.construct(numberOfBubble)
                arrayRow.append(myBubble)

                if myBubble.status == myBubble.statusON {
                    self.totalOn++
                }
                
                axisX = axisX + width + margin
                numberOfBubble++
            }
            self.collection.insert(arrayRow, atIndex: row)
            // Reiniciar eje X e Y
            axisX = self.initX
            axisY = axisY + height + margin
        }
    }
    
    func getCollection () -> [[Bubble]] {
        return self.collection
    }
    
    func getBubble(row: Int, col: Int) -> Bubble? {
        if row >= 0 && row < self.rows && col >= 0 && col < self.cols  {
            return self.collection[row][col]
        }
        return nil
    }
    
    func getBubbleByIndex(index: Int) -> Bubble? {
        for row in self.collection {
            for booble in row {
                if (booble.myButton.tag == index) {
                    return booble
                }
            }
        }
        return nil
    }
    
    func toggleByPosition(row: Int, col: Int) {
        if let bubble = self.getBubble(row, col: col) {
            self.toggleBubble(bubble)
        }
        
    }
    
    func toggleAroundBubble(bubble: Bubble) {
        let row = bubble.row
        let col = bubble.col
        
        self.toggleBubble(bubble)
        
        // UP
        self.toggleByPosition(row-1, col: col)
        // DOWN
        self.toggleByPosition(row+1, col: col)
        // LEFT
        self.toggleByPosition(row, col: col-1)
        // RIGHT
        self.toggleByPosition(row, col: col+1)
    }
    
    func updateTotalBubblesOn (bubble: Bubble) {
        if bubble.status == bubble.statusON {
            self.totalOn = self.totalOn+1
        } else if self.totalOn > 0 {
            self.totalOn = self.totalOn-1
        }
    }
    
    func toggleBubble(bubble: Bubble) {
        bubble.toggle()
        self.updateTotalBubblesOn(bubble)
    }
    
}
