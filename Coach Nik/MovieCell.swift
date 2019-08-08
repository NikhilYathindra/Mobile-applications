//
//  MovieCell.swift
//  gameofchats
//
//  Created by Nikhil Yathindra on 4/26/18.
//  Copyright © 2018 Nikhil Yathindra. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    //    var viewController: ViewController?
    var titleLabel: UILabel!
    var overviewLabel: UILabel!
    var posterLabel: UIImageView!
    var videoView: UIWebView!
    let webV = UIWebView()
    var videoKey: String?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.frame = CGRect(x: 20, y: 15, width: bounds.width, height: bounds.height)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        
        overviewLabel = UILabel()
        overviewLabel.textColor = UIColor.rgb(red: 139, green: 69, blue: 19)
        overviewLabel.font = UIFont.systemFont(ofSize: 0)
        overviewLabel.frame = CGRect(x: 20, y: 32.5, width: bounds.width - 50, height: bounds.height)
        overviewLabel.lineBreakMode = .byWordWrapping
        overviewLabel.numberOfLines = 0
        addSubview(overviewLabel)
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        //overviewLabel.leftAnchor.constraint(equalTo: posterLabel.rightAnchor, constant: 8).isActive = true
        overviewLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        overviewLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        posterLabel = UIImageView()
        posterLabel.frame = CGRect(x: 295, y: 7, width: 60, height: 60)
        addSubview(posterLabel)
        posterLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        posterLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        posterLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        videoView = UIWebView()
        videoView.frame = CGRect(x: 20, y: 500, width: bounds.width - 50, height: 300)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 16, 0, 16))
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    @available(iOS 11.0, *)
    func setup() {
        addSubview(cellView)
        cellView.topAnchor.constraintEqualToSystemSpacingBelow(topAnchor, multiplier: 2)
        cellView.bottomAnchor.constraintEqualToSystemSpacingBelow(bottomAnchor, multiplier: 2)
        cellView.preservesSuperviewLayoutMargins = false
        cellView.layoutMargins = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
