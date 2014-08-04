//
//  PhotoTableViewController.swift
//  Swiftagram
//
//  Created by Robert Manson on 7/29/14.
//  Copyright (c) 2014 Robert Manson. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController {
    var images:[ISImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None

        HttpClient.sharedInstance.imagesAtLat(37.7773285, lng: -122.407204, onError: {error in}) {[weak self] images in
            if let wSelf = self {
                wSelf.images = images
                wSelf.tableView.reloadData()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let instagramImage = images[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as PhotoTableViewCell
        let placeholderImage = UIImage(named: "placeholder.png")
        cell.photoImageView.setImageWithURL(NSURL(string: instagramImage.url), placeholderImage: placeholderImage)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 320
    }
    override func tableView(tableView: UITableView!, shouldHighlightRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return false
    }
}
