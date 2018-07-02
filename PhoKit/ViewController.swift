//
//  ViewController.swift
//  PhoKit
//
//  Created by formathead on 2018. 6. 5..
//  Copyright © 2018년 formathead. All rights reserved.
//

import UIKit
import Photos


class ViewController: UIViewController
{

    @IBOutlet weak var imageView: UIImageView!
    
    var asset:PHAsset?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let effectBtn:UIBarButtonItem = UIBarButtonItem(title: "Effect", style: UIBarButtonItemStyle.plain, target: self, action: #selector(applyEffect))
        if (self.asset?.mediaType == PHAssetMediaType.image)
        {
            self.navigationItem.rightBarButtonItem = effectBtn
        }
        
        showImage()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   @objc func applyEffect()
    {
        let alertController = UIAlertController(title: "title", message: "message", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alertController.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title:"Mono", style: UIAlertActionStyle.default
            , handler: {
                (action:UIAlertAction) in
                self.applyFilter("CIPhotoEffectMono")
                
        }))
        
        alertController.addAction(UIAlertAction(title: "Instant", style: UIAlertActionStyle.default, handler: {
            (action:UIAlertAction) in
            self.applyFilter("CIPhotoEffectInstant")
        }))
        
        alertController.modalPresentationStyle = UIModalPresentationStyle.popover
        self.present(alertController, animated: true, completion: nil)
        
    }
    

    func applyFilter(_ filterName:String)
    {
        self.asset?.requestContentEditingInput(with: nil, completionHandler:
            {
                (inputContent:PHContentEditingInput?, _:[AnyHashable:Any]?) -> Void  in
                //https://dev.classmethod.jp/smartphone/iphone/swift-3-how-to-use-gcd-api-1/
                DispatchQueue.global().async(execute:
                    {
                        () in
                        let url =  inputContent?.fullSizeImageURL
                        let orientation = inputContent?.fullSizeImageOrientation
                        var inputImage = CIImage(contentsOf: url!, options: nil)
                        inputImage = inputImage?.oriented(forExifOrientation: orientation!)
                        
                        //https://picolica.com/2017/03/12/swift3-photo-filter/
                        let filter = CIFilter(name: filterName)
                        filter?.setDefaults()
                        filter?.setValue(inputImage, forKey: kCIInputImageKey)
                        let outputImg = filter?.outputImage
                        
                        let context = CIContext()
                        let image = context.createCGImage(outputImg!, from: outputImg!.extent)
                        let uiImage = UIImage(cgImage: image!)
                        
                        let contentOutput = PHContentEditingOutput(contentEditingInput: inputContent!)
                        let renderedData = UIImageJPEGRepresentation(uiImage, 0.9)
                        
                        if (((try? renderedData?.write(to: contentOutput.renderedContentURL, options: [.atomic])) != nil) != nil)
                        {
                            let archiveData = NSKeyedArchiver.archivedData(withRootObject: filterName)
                            let adjData = PHAdjustmentData(formatIdentifier: "com.gbustudio.photo", formatVersion: "1.0", data: archiveData)
                            contentOutput.adjustmentData = adjData
                            
                            
                            
                        }
                        
                        
            
                        
                        
                        
                        
                        
                        
                    })
            
            })
    }
    
    func showImage()
    {
        let scale = UIScreen.main.scale
        let size = CGSize(width: self.imageView.bounds.width * scale, height: self.imageView.bounds.height * scale)
        
        let imageManager = PHImageManager.default().requestImage(for: self.asset!, targetSize: size, contentMode: PHImageContentMode.aspectFit, options: nil, resultHandler:
        {
            (result:UIImage?, info:[AnyHashable:Any]?) -> Void in
            self.imageView.image = result
        })
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

