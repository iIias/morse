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

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    
    @IBAction func flashButton(_ sender: Any) {
        morse2flash()
    }
    
    func morse2flash() {
        var count = 1.0
        
            for char in self.translatedTextView.text.characters {
                count+=1
                DispatchQueue.main.asyncAfter(deadline: .now() + count) {
                    if char == "." {
                        self.shortFlash()
                    } else if char == "-" {
                        self.longFlash()
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
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func shortFlash() {
        toggleFlash()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            self.stopFlash()
        })
    }
    
    func longFlash() {
        toggleFlash()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            self.stopFlash()
        })
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

    func toggleFlash() {
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
        translatedTextView.text = textView.text
        
        if textView.text != nil {
            let outputText = convertStringToMorse(input: textView.text)
            self.translatedTextView.text = outputText
        }
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



