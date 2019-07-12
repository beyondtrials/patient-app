//
//  SearchVC.swift
//  patient-app
//
//  Created by Elliott Brunet on 12.07.19.
//  Copyright © 2019 Elliott Brunet. All rights reserved.
//

import UIKit
import AVFoundation

class SearchVC: UIViewController {

    @IBOutlet weak var cameraFrameView: UIView!
    @IBOutlet weak var drugTextField: UITextField!
    
    var barcodeFrameView: UIView?
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var didDetectBarcode = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nav = self.navigationController?.navigationBar
//        nav?.barStyle = UIBarStyle.black
//        nav?.tintColor = UIColor.yellow
        nav?.topItem?.title = "Search"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self as? AVCaptureMetadataOutputObjectsDelegate, queue: DispatchQueue.main)
            //----->set specific for barcode<-----\\
            captureMetadataOutput.metadataObjectTypes = self.metaObjectTypes()
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = cameraFrameView.layer.bounds
            cameraFrameView.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession.startRunning()
            
            // Move the message label and top bar to the front
//            view.bringSubviewToFront(messageLabel)
            
            //QR CODE SCANNING
            
            //Initialize QR Code Frame to highlight the QR code
            barcodeFrameView = UIView()
            
            if let barcodeFrameView = barcodeFrameView {
                barcodeFrameView.layer.borderColor = UIColor.green.cgColor
                barcodeFrameView.layer.borderWidth = 2
                cameraFrameView.addSubview(barcodeFrameView)
                cameraFrameView.bringSubviewToFront(barcodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
    }
    
    private func metaObjectTypes() -> [AVMetadataObject.ObjectType] {
        return [.qr,
                .code128,
                .code39Mod43,
                .code93,
                .ean13,
                .ean8,
                .interleaved2of5,
                .itf14,
                .pdf417,
                .upce,
                .aztec,
                .dataMatrix,
                .code39]
    }
    
    private func createPreviewLayer(withCaptureSession captureSession: AVCaptureSession, view: UIView) -> AVCaptureVideoPreviewLayer {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        
        return previewLayer
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchVC: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        print("detected something")
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            barcodeFrameView?.frame = CGRect.zero
//            messageLabel.text = "No QR code is detected"
            return
        }

        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        
        let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
        barcodeFrameView?.frame = barCodeObject!.bounds
        
        if (metadataObj.stringValue != nil && !didDetectBarcode) {
            print(metadataObj.stringValue)
            drugTextField.text = metadataObj.stringValue
            
            performSegue(withIdentifier: "showDrugDetailFromSearch", sender: nil)
            
            didDetectBarcode = true
        }
        

//        if metadataObj.type == AVMetadataObject.ObjectType.qr {
//            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
//            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
//            barcodeFrameView?.frame = barCodeObject!.bounds
//
//            if metadataObj.stringValue != nil {
//                print(metadataObj.stringValue)
////                messageLabel.text = metadataObj.stringValue
//
////                if (!isRequestShowing) {
////                    setView(view: requestView)
////                    isRequestShowing = true
////                }
//            }
//        }
    }
}
