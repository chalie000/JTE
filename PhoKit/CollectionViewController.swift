//
//  CollectionViewController.swift
//  PhoKit
//
//  Created by formathead on 2018. 6. 5..
//  Copyright © 2018년 formathead. All rights reserved.
//

import UIKit

class CollectionViwController:UICollectionViewController
{
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 7
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ImageCell", for: indexPath) as! ImageCellController
        let image = UIImage(named: "images/0\(indexPath.row + 1).jpeg")
        cell.imageView.image = image
        
        return cell
        
        
    }
    
    //Image Data Pass
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        (segue.destination as! ViewController).image = (sender as! ImageCellController).imageView.image!
        
    }
    
    
    
    
    
    
    
}
