//
//  CollectionViewController.swift
//  PhoKit
//
//  Created by formathead on 2018. 6. 5..
//  Copyright © 2018년 formathead. All rights reserved.
//

import UIKit
import Photos


class CollectionViwController:UICollectionViewController
{
    var assetsFetchResults:PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()
    var imageManager:PHCachingImageManager!
    
    
    override func viewDidLoad()
    {
        PHPhotoLibrary.requestAuthorization()
        {
            (status) in switch status
            {
            case .authorized:
                self.imageManager = PHCachingImageManager()
                let options = PHFetchOptions()
                options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
                self.assetsFetchResults = PHAsset.fetchAssets(with: options)
                self.collectionView?.reloadData()
                
            default:
                NSLog("Can Not Acccess Photo")
                    
            }
                
        }
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return assetsFetchResults.count
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ImageCell", for: indexPath) as! ImageCellController
        let asset:PHAsset = self.assetsFetchResults[indexPath.item]
        self.imageManager.requestImage(for: asset, targetSize: cell.frame.size, contentMode: PHImageContentMode.aspectFit, options: nil)
        {
            (result:UIImage?, [AnyHashable:Any?]) in
            cell.imageView.image = result
            
        }
        
        return cell
        
        
    }
    
    //Image Data Pass
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        (segue.destination as! ViewController).image = (sender as! ImageCellController).imageView.image!
        
    }
    
    
    
    
    
    
    
}
