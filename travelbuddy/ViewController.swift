//
//  ViewController.swift
//  travelbuddy
//
//  Created by Edmund Mai on 11/28/15.
//  Copyright © 2015 Edmund Mai. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController, ADBannerViewDelegate {
  
  var bannerView: ADBannerView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.canDisplayBannerAds = true
    self.bannerView?.delegate = self
    self.bannerView?.hidden = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func largeImageTapped(sender: UITapGestureRecognizer) {
    let enlargedView = sender.view!
    UIView.beginAnimations(nil, context: nil)
    enlargedView.alpha = 0.0
    UIView.commitAnimations()
    enlargedView.removeFromSuperview()
  }
  
  func bannerViewDidLoadAd(banner: ADBannerView!) {
    self.bannerView?.hidden = false
  }
  
  func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
    self.bannerView?.hidden = true
  }
  
  func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
    return willLeave
  }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return iconMapper.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell: IconCell = collectionView.dequeueReusableCellWithReuseIdentifier("icon", forIndexPath: indexPath) as! IconCell
    print(indexPath.row)
    cell.imageView.image = UIImage(named: iconMapper[indexPath.row]!)
    
    return cell
    
  }
  
  func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    let cell: IconCell = collectionView.cellForItemAtIndexPath(indexPath) as! IconCell
    
    cell.imageView.alpha = 0.5
    return true
  }
  
  func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
    let cell: IconCell = collectionView.cellForItemAtIndexPath(indexPath) as! IconCell
    cell.imageView.alpha = 1.0
  }
  
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let cell: IconCell = collectionView.cellForItemAtIndexPath(indexPath) as! IconCell
    
    let enlargedView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    enlargedView.backgroundColor = UIColor(red: 0, green: 111, blue: 234, alpha: 1.0)
    
    let enlargedImageView = UIImageView(frame: CGRectMake(UIScreen.mainScreen().bounds.width*0.1, UIScreen.mainScreen().bounds.height/4, UIScreen.mainScreen().bounds.width*0.8, UIScreen.mainScreen().bounds.height/2))
    enlargedImageView.image = cell.imageView.image
    
    enlargedView.addSubview(enlargedImageView)
    
    let translationTextLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.width*0.1, UIScreen.mainScreen().bounds.height * 4/5, UIScreen.mainScreen().bounds.width*0.8, 30))
    translationTextLabel.text = iconMapper[indexPath.row]!
    translationTextLabel.font = UIFont.systemFontOfSize(25)
    

    translationTextLabel.textAlignment = NSTextAlignment.Center
    
    enlargedView.addSubview(translationTextLabel)

    let tap = UITapGestureRecognizer(target: self, action: Selector("largeImageTapped:"))
    enlargedView.addGestureRecognizer(tap)
    
    enlargedView.alpha = 0.0
    self.view.addSubview(enlargedView)
    UIView.beginAnimations(nil, context: nil)
    enlargedView.alpha = 1.0
    UIView.commitAnimations()
  }
}