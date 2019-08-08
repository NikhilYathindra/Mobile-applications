//
//  DetailedController.swift
//  gameofchats
//
//  Created by Nikhil Yathindra on 4/26/18.
//  Copyright © 2018 Nikhil Yathindra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class DetailedController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIWebViewDelegate {
    
    var categoryController: CategoryController?
    let vc = CategoryController()
    var mtitle: String?
    var movieID: Int?
    var releaseDate: String?
    var overview: String?
    var image_path: UIImage?
    var backdrop_path: String?
    var movieRating: Double?
    var genreId: [Int]?
    var genre: String = ""
    var gID: Int?
    var tagline: [String]?
    var gen: String?
    var videoKey: String?
    var originalTitle: String?
    var language: String?
    let webV = UIWebView()
    var movies: [NSDictionary]?
    private let detailedCellID = "detailedCellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.rgb(red: 245, green: 222, blue: 179)
        navigationItem.title = mtitle
        navigationController?.navigationBar.isTranslucent = false
        //        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25)]
        collectionView?.register(CollectionCell.self, forCellWithReuseIdentifier: detailedCellID)
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        layout?.minimumLineSpacing = 0
        collectionView?.isPagingEnabled = true
        let image = UIImage(named: "new_message_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleChat))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self,  action: #selector(handleCloseBook))
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
    }
    
    @objc func handleCloseBook() {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dcell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailedCellID", for: indexPath) as! CollectionCell
        var videoKey: String?
        
        if indexPath.row == 0 {
            dcell.overviewLabel.text = overview
            dcell.overviewLabel.textColor = UIColor.rgb(red: 139, green: 69, blue: 19)
            dcell.backgroundColor = UIColor.rgb(red: 245, green: 222, blue: 179)
            dcell.imageLabel.image = image_path
            dcell.imageLabel.contentMode = .scaleAspectFill
        }
            
        else if indexPath.row == 1 {
            dcell.imageLabel.image = image_path
            dcell.imageLabel.contentMode = .scaleAspectFill
            webV.backgroundColor = UIColor.clear
            webV.isOpaque = false
            webV.frame  = CGRect(x: 20, y: 358, width: UIScreen.main.bounds.width - 50, height: 500)
            
            webV.loadRequest(NSURLRequest(url: NSURL(string: "https://www.youtube.com/watch?v=aZlKZxavH3k")! as URL) as URLRequest)
            webV.delegate = self
            self.view.addSubview(webV)
            
        }
            
        else {
            dcell.imageLabel.image = image_path
            dcell.imageLabel.contentMode = .scaleToFill
            webV.backgroundColor = UIColor.clear
            webV.isOpaque = false
            webV.frame  = CGRect(x: 20, y: 530, width: UIScreen.main.bounds.width - 50, height: 226)
            webV.loadRequest(NSURLRequest(url: NSURL(string: "about:blank")! as URL) as URLRequest)
            webV.delegate = self
            self.view.addSubview(webV)
        }
        
        
        dcell.imageLabel.layer.masksToBounds = true
        
        return dcell
    }
    
    @objc func handleChat() {
        let messagesController = MessagesController()
        messagesController.detailedController = self
        let navController = UINavigationController(rootViewController: messagesController)
        present(navController, animated: true, completion: nil)
    }
    
}
