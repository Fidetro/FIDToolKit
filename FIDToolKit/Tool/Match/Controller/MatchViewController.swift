
//
//  MatchViewController.swift
//  FIDToolKit
//
//  Created by Fidetro on 2017/1/24.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit

class MatchViewController: BaseViewController {

    var selectImage = UIImage();
    var timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: 0), queue: DispatchQueue.global());
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.timer.resume();
        weak var weakSelf = self;
        self.createActionSheet { (imagePath) in
            
            self.selectImage = UIImage(contentsOfFile: imagePath!)!;
            
            let cameraView = FIDCameraHelper.setCameraWithBounds(self.view.bounds);
            self.view.addSubview(cameraView!);
            FIDCameraHelper.startRunning();
            
            weakSelf?.timer.scheduleRepeating(deadline: .now(), interval: DispatchTimeInterval.seconds(2));
            weakSelf?.timer.setEventHandler(handler: {
                
             let han =  GreyImageMatch.getSuitabilityWithImageA(self.selectImage, imageB: FIDCameraHelper.cameraImage());
                print("\(han)");
                
            });
           
            
            
        }
        
    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    



}
