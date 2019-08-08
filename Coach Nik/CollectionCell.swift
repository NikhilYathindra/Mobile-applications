//
//  CollectionCell.swift
//  gameofchats
//
//  Created by Nikhil Yathindra on 4/26/18.
//  Copyright © 2018 Nikhil Yathindra. All rights reserved.
//

import UIKit

protocol CollectionCellDelegate {
    func didTapComment()
    func didLike(for cell: CollectionCell)
}

class CollectionCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var overviewLabel: UITextView!
    var imageLabel: UIImageView!
    var videoView: UIWebView!
    var videoKey: String?
    var delegate: CollectionCellDelegate?
    
    
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = UIColor.rgb(red: 139, green: 69, blue: 19)
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLike(sender: UIButton!) {
        print("Handling like from within cell...")
        likeButton.setImage(#imageLiteral(resourceName: "like_selected"), for: .normal)
        likeButton.tintColor = UIColor.rgb(red: 139, green: 69, blue: 19)
        delegate?.didLike(for: self)
    }
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        return button
    }()
    
    @objc func handleComment() {
        print("Trying to show comments...")
        //        guard let post = post else { return }
        
        delegate?.didTapComment()
    }
    
    let captionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let dcellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.rgb(red: 139, green: 69, blue: 19)
        
        videoView = UIWebView()
        videoView.frame = CGRect(x: 20, y: 500, width: bounds.width - 50, height: 300)
        addSubview(videoView)
        
        overviewLabel = UITextView()
        overviewLabel.textColor = UIColor.rgb(red: 139, green: 69, blue: 19)
        overviewLabel.backgroundColor = UIColor.rgb(red: 245, green: 222, blue: 179)
        overviewLabel.font = overviewLabel.font?.withSize(100)
        overviewLabel.font = .systemFont(ofSize: 22)
        overviewLabel.frame = CGRect(x: 20, y: 375, width: bounds.width - 50, height: bounds.height)
        overviewLabel.textAlignment = NSTextAlignment.justified
        addSubview(overviewLabel)
        overviewLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        overviewLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.frame = CGRect(x: 20, y: 40, width: bounds.width, height: bounds.height)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        
        imageLabel = UIImageView()
        imageLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 350)
        addSubview(imageLabel)
        imageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        imageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        imageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        imageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(iOS 11.0, *)
    func setup() {
        addSubview(dcellView)
        dcellView.topAnchor.constraintEqualToSystemSpacingBelow(topAnchor, multiplier: 2)
        dcellView.bottomAnchor.constraintEqualToSystemSpacingBelow(bottomAnchor, multiplier: 2)
        dcellView.preservesSuperviewLayoutMargins = false
        dcellView.layoutMargins = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
    
}
