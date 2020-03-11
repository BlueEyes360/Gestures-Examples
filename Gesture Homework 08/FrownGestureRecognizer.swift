//
//  FrownGestureRecognizer.swift
//  Gesture Homework 08
//
//  Created by Bobby Thompson on 3/9/20.
//  Copyright © 2020 Bobby Thompson. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class FrownGestureRecognizer: UIGestureRecognizer {

    var initialPoint: CGPoint!
    var previousPoint: CGPoint!
    var topFlag: Bool = false

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        print("frown: touchesBegan")
        let touch = touches.first
        clearBoxes()
        if let point = touch?.location(in: self.view) {
            initialPoint = point
            previousPoint = point
            state = .began
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            if topFlag {
                print("frown: touchesMoved: topFlag true")
                if ((point.x >= previousPoint.x) && (point.y >= previousPoint.y)) {
                    previousPoint = point
                    state = .changed
                    drawBox(point)
                } else {
                    state = .failed
                }
            } else {
                if (point.x >= previousPoint.x && point.y <= previousPoint.y) {
                    print("frown: touchesMoved: topFlag false")
                    previousPoint = point
                    state = .changed
                    drawBox(point)
                } else if (point.x >= previousPoint.x && point.y >= previousPoint.y ) {
                    print("frown: touchesMoved: top reached")
                    previousPoint = point
                    state = .changed
                    drawBox(point)
                    topFlag = true
                } else {
                    state = .failed
                }
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        print("frown: touchesEnded")
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            let d = distance(point, initialPoint)
//            if (point != initialPoint) {
            if (d > 100.0) {
                state = .ended
            } else {
                state = .failed
            }
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        print("frown: touchesCancelled")
        state = .cancelled
    }

    override func reset() {
        print("frown: reset")
        topFlag = false
    }
    
    func distance(_ point1: CGPoint, _ point2: CGPoint) -> Double {
        let xdiff = point1.x - point2.x
        let ydiff = point1.y - point2.y
        return Double(sqrt(xdiff*xdiff + ydiff*ydiff))
    }
    
    var boxViews: [UIView] = []

    func drawBox(_ point: CGPoint) {
        let boxRect = CGRect(x: point.x, y: point.y,
        width: 5.0, height: 5.0)
        let boxView = UIView(frame: boxRect)
        boxView.backgroundColor = UIColor.red
        self.view?.addSubview(boxView)
        boxViews.append(boxView)
    }

    func clearBoxes() {
        for boxView in boxViews {
            boxView.removeFromSuperview()
        }
        boxViews.removeAll()
    }
}
