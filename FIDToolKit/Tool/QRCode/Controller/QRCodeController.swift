//
//  QRCodeController.swift
//  FIDToolKit
//
//  Created by Fidetro on 2017/1/16.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStatus();
        
        
    }

    
    /// 获取相机状态权限
    func setupStatus() {
       let authorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo);
        
        switch authorizationStatus {
            
        case .notDetermined:
            print("访问不确定")

            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted:Bool) in
                self.setupCapture();

            });
            
            
        case .restricted:
            print("访问限制")

            
        case .denied:

            print("访问拒绝")

        case .authorized:
            
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted:Bool) in
                self.setupCapture();
                
            });
            print("访问允许")

        }
        
    }
    
    /// 设置开启摄像头
    func setupCapture() {
        
        OperationQueue.main.addOperation {
            
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo);
          
        
            do{
            
                let deviceInput = try AVCaptureDeviceInput.init(device: device);
                
                if deviceInput as AVCaptureDeviceInput? != nil {
                    
                    self.session.addInput(deviceInput);
                    let metadataOutput = AVCaptureMetadataOutput();
                    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main);
                    self.session.addOutput(metadataOutput);
                    metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode];
             
                    self.view.layer.insertSublayer(self.previewLayer, at: 0);
                    NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: OperationQueue.current, using: { (notification : Notification) in
                        
                    });
                    self.session.startRunning();
                    
                }
                
                
            }catch let error as NSError{
            
                print("\(error)")
                
            }
            
        } ;
  
    }
    
    /// 捕获输出的内容
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        let metadataObject = metadataObjects.first;
        
        if (metadataObject as? AVMetadataMachineReadableCodeObject)?.type == AVMetadataObjectTypeQRCode {
            
                let msg = (metadataObject as? AVMetadataMachineReadableCodeObject)?.stringValue;
            
            print("\((metadataObject as? AVMetadataMachineReadableCodeObject)?.stringValue)");
            
            let alertVC = UIAlertController.init(title: "", message: msg, preferredStyle: .alert);
            
            
            if (self.QRCodeMsg == nil){
                print("present");
                self.QRCodeMsg = msg;
                self.present(alertVC, animated: true, completion: nil);
            }
           DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3), execute: {
            
            self.QRCodeMsg = nil;
            self.dismiss(animated: true, completion: nil);
         

            
           });
            
            
        }
        
        
    }
    
  

    
    //会话
    private lazy var session:AVCaptureSession = {
        let session = AVCaptureSession()
        return session
    }();
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer?.frame = UIScreen.main.bounds
        return layer!
    }();
    
    var QRCodeMsg : String!;
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

 

}
