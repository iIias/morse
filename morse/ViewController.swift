//
//  ViewController.swift
//  morse
//
//  Created by Ilias Ennmouri on 27.03.17.
//  Copyright © 2017 Ilias Ennmouri. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, UITextViewDelegate {

    let avDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    
    @IBAction func flashButton(_ sender: Any) {
        morse2flash()
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        switch segmentController.selectedSegmentIndex {
        case 0:
            translatedTextView.text = textView.text
            if textView.text != nil {
                let outputText = convertStringToITU(input: textView.text)
                self.translatedTextView.text = outputText;
            }
        case 1:
            translatedTextView.text = textView.text
            
            if textView.text != nil {
                let outputText = convertStringToMorse(input: textView.text)
                self.translatedTextView.text = outputText
            }
        default:
            break;
        }
    }

    func morse2flash() {
        var count = 1.0
        var flashtext: String = translatedTextView.text
        if let nothingRange = flashtext.range(of: "--") {
            flashtext.replaceSubrange(nothingRange, with: "-^-")
        }
        for char in flashtext.characters {
                count+=1
                DispatchQueue.main.asyncAfter(deadline: .now() + count) {
                    print(char)
                    if char == "." {
                        self.startFlash()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            self.stopFlash()
                        })
                    } else if char == "-" {
                        self.startFlash()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            self.stopFlash()
                        })
                    } else {
                    }
            }
        }
    }
    
    
    func nothing() {
        print("nothing o.o")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        self.setNeedsStatusBarAppearanceUpdate()
        self.segmentController.layer.cornerRadius = 8.0
        self.segmentController.layer.borderWidth = 1.0
        self.segmentController.layer.borderColor = UIColor.white.cgColor
        self.segmentController.layer.masksToBounds = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func stopFlash() {
        if (avDevice?.hasTorch)! {
            do {
                _ = try avDevice?.lockForConfiguration()
            } catch {
                print("aaaa")
            }
            avDevice?.torchMode = AVCaptureTorchMode.off
            avDevice?.unlockForConfiguration()
        }
    }

    func startFlash() {
        let avDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        // check if the device has torch
        if (avDevice?.hasTorch)! {
            // lock your device for configuration
            do {
                _ = try avDevice?.lockForConfiguration()
            } catch {
                print("aaaa")
            }
            
            // check if your torchMode is on or off. If on turns it off otherwise turns it on
            if (avDevice?.isTorchActive)! {
                avDevice?.torchMode = AVCaptureTorchMode.off
            } else {
                // sets the torch intensity to 100%
                do {
                    _ = try avDevice?.setTorchModeOnWithLevel(1.0)
                } catch {
                    print("bbb")
                }
                //    avDevice.setTorchModeOnWithLevel(1.0, error: nil)
            }
            // unlock your device
            avDevice?.unlockForConfiguration()
            }
        }

    func textViewDidChange(_ textView: UITextView) {
        switch segmentController.selectedSegmentIndex {
        case 0:
            translatedTextView.text = textView.text
            if textView.text != nil {
                let outputText = convertStringToITU(input: textView.text)
                self.translatedTextView.text = outputText;
            }
        case 1:
            translatedTextView.text = textView.text
            
            if textView.text != nil {
                let outputText = convertStringToMorse(input: textView.text)
                self.translatedTextView.text = outputText
            }
        default:
            break;
        }
        }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



