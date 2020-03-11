//
//  ViewController.swift
//  Gesture Homework 08
//
//  Created by Bobby Thompson on 3/9/20.
//  Copyright © 2020 Bobby Thompson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var EmojiImage: UIImageView!
    @IBOutlet weak var EmojiLabel: UILabel!
    @IBOutlet weak var ClearButton: UIButton!
    
    var smileGestureRecognizerGlobal: SmileGestureRecognizer!
    var frownGestureRecognizerGlobal: FrownGestureRecognizer!

    @IBAction func ClearPushed(_ sender: UIButton) {
        EmojiLabel.text = ""
        EmojiImage.image = nil
        smileGestureRecognizerGlobal.clearBoxes()
        frownGestureRecognizerGlobal.clearBoxes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        EmojiLabel.text = ""
        EmojiImage.image = nil
        
        let smileGestureRecognizer = SmileGestureRecognizer(target: self, action: #selector(handleSmile))
        smileGestureRecognizer.delegate = self
        smileGestureRecognizerGlobal = smileGestureRecognizer
        self.view.addGestureRecognizer(smileGestureRecognizer)

        let frownGestureRecognizer = FrownGestureRecognizer(target: self, action: #selector(handleFrown))
        frownGestureRecognizer.delegate = self
        frownGestureRecognizerGlobal = frownGestureRecognizer
        self.view.addGestureRecognizer(frownGestureRecognizer)
    }

    @objc func handleSmile(_ sender: SmileGestureRecognizer) {
        if sender.state == .ended {
            print("smile detected")
            EmojiLabel.text = "Tastes Good!"
            EmojiImage.image = UIImage(named: "tasty.png")
        }
    }

    @objc func handleFrown(_ sender: FrownGestureRecognizer) {
        if sender.state == .ended {
            print("frown detected")
            EmojiLabel.text = "Tastes bad!"
            EmojiImage.image = UIImage(named: "nasty.jpeg")
        }
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
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton {
            return false
        }
        // Add more checks for other types of view elements, as needed
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is FrownGestureRecognizer {
            if otherGestureRecognizer is SmileGestureRecognizer {
                return true
            }
        }
        return false
    }
    
}
