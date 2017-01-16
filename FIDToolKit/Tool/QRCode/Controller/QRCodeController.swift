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
            print("访问允许")
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted:Bool) in
                self.setupCapture();

            });
            
            
        case .restricted:
            print("访问拒绝")
        case .denied:
            print("访问不确定")
        case .authorized:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted:Bool) in
                self.setupCapture();
                
            });
            print("访问限制")
       
        }
        
    }
    
    /// 设置捕获二维码
    func setupCapture() {
        
        OperationQueue.main.addOperation {
            
           let session = AVCaptureSession();
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo);
          
        
            do{
            
                let deviceInput = try AVCaptureDeviceInput.init(device: device);
                
                if deviceInput as AVCaptureDeviceInput? != nil {
                    
                    session.addInput(deviceInput);
                    let metadataOutput = AVCaptureMetadataOutput();
                    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main);
                    session.addOutput(metadataOutput);
                    metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode];
                    let previewLayer = AVCaptureVideoPreviewLayer.init(sessionWithNoConnection: session);
                    previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill;
                    previewLayer!.frame = self.view.bounds;
                    self.view.layer.insertSublayer(previewLayer!, at: 0);
                    NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: OperationQueue.current, using: { (notification : Notification) in
//                        metadataOutput.rectOfInterest = previewLayer!.metadataOutputRectOfInterest(for: self.view.bounds);
                    });
                    session.startRunning();
                    
                }
                
                
            }catch let error as NSError{
            
                print("\(error)")
                
            }
            
        } ;
  
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        let metadataObject = metadataObjects.first;
        
        if (metadataObject as? AVMetadataMachineReadableCodeObject)?.type == AVMetadataObjectTypeQRCode {
            
            print("\((metadataObject as? AVMetadataMachineReadableCodeObject)?.stringValue)");
            
        }
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage];
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

 

}
