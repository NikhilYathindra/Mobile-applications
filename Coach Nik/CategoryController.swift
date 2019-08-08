//
//  CategoryController.swift
//  gameofchats
//
//  Created by Nikhil Yathindra on 4/26/18.
//  Copyright © 2018 Nikhil Yathindra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Movie {
    let title: String
    let description: String
    let image: UIImage
    let id: Int32
    let movies: [Overview]
    
    init(title: String, description: String, image: UIImage, movies: [Overview], id: Int32) {
        self.title = title
        self.description = description
        self.image = image
        self.movies = movies
        self.id = id
    }
}

class Overview {
    let rating: Int
    let text: String
    
    init(rating: Int, text: String) {
        self.rating = rating
        self.text = text
    }
}



class CategoryController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate {
    
    var messagesController: MessagesController?
    var movies = ["Stretching", "Warm up", "Conditioning", "Dribbling", "Passing", "Shooting", "Rebounding", "Defence", "Rules"]
    var tableView = UITableView()
    let movieCellId = "movieCellId"
    var mv: [Movie]?
    var taglines: [NSDictionary]?
    var ID: Int?
    let webV = UIWebView()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavigationBar()
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: movieCellId)
        tableView.tableFooterView = UIView()
        tableView.frame = self.view.frame
        self.view.addSubview(tableView)
        self.tableView.backgroundColor = UIColor.rgb(red: 245, green: 222, blue: 179)
        tableView.delegate = self
        tableView.dataSource = self
        let image = UIImage(named: "new_message_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleChat))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.rgb(red: 245, green: 222, blue: 179)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.rgb(red: 245, green: 222, blue: 179)
        
        
    }
    
    @objc func handleLogout() {
        
        
        let user = Auth.auth().currentUser
        
        try! Auth.auth().signOut()
        
        
        
        let authenticationViewController = LoginController()
        present(authenticationViewController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.movies.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        var overview = UITextView()
        var posterPath = UIImage()
        var title = UILabel()
        var count: Int?
        var videoView = UIWebView()
        
        if indexPath.row == 0 {
            posterPath = #imageLiteral(resourceName: "stretch")
            overview.text = "Stretching keeps the muscle flexible, strong and healthy, and we need that flexibility to maintain a range of motion in the joints. Without it, the muscles shorten and become tight. Then, when to call on the muscle for activity, they are weak and unable to extend all the way. That puts on risk for join pain, strains and muscle damage."
            count = 0
            
        }
        else if indexPath.row == 1 {
            posterPath = #imageLiteral(resourceName: "warm up")
            overview.text = "A thorough warm-up helps increase the blood flow to the working muscle which results in decreased muscle stiffness, reduced risk of injury and often, improved performance. Additional benefits of warming up include physiological and psychological preparation for more extreme exercise."
            count = 1
            
        }
        else if indexPath.row == 2 {
            posterPath = #imageLiteral(resourceName: "conditioning")
            overview.text = "As with many other types of exercise, strength and conditioning can actually increase your metabolism, helping you lose weight and maintain a healthy lifestyle. By creating stronger muscles through strength and conditioning, you will burn more calories and keep the unwanted pounds."
            count = 2
        }
        else if indexPath.row == 3 {
            posterPath = #imageLiteral(resourceName: "dribbling")
            overview.text = "Dribbling is the legal method of advancing the ball by oneself, as opposed to passing it to another player or shooting for the basket. It consists of bouncing the ball on the floor continuously with one hand while walking or running down the court."
            count = 3
        }
        else if indexPath.row == 4 {
            posterPath = #imageLiteral(resourceName: "passing")
            overview.text = "Passing in basketball has been defined as : The deliberate attempt to move a live ball between two teammates,a definition which might equally apply across other sports equally well, albeit with a change to the item being passed where appropriate."
            count = 4
        }
        else if indexPath.row == 5 {
            posterPath = #imageLiteral(resourceName: "shooting")
            overview.text = "In basketball (and derivatives like netball), a regular jump shot or jumper is an attempt to score a basket by jumping, usually straight up, and in mid-jump, propelling the ball in an arc into the basket. Shots that are made within the 30 ft arc account for two points and anything outside the arc account for three points"
            count = 5
        }
        else if indexPath.row == 6 {
            posterPath = #imageLiteral(resourceName: "rebound")
            overview.text = "In basketball, a rebound, colloquially referred to as a board, is a statistic awarded to a player who retrieves the ball after a missed field goal or free throw. Rebounds are also given to a player who tips in a missed shot on his team's offensive end."
            count = 6
        }
        else if indexPath.row == 7 {
            posterPath = #imageLiteral(resourceName: "defence")
            overview.text = "The ball is moved down the court toward the basket by passing or dribbling. The team with the ball is called the offense. The team without the ball is called the defense. They try to steal the ball, contest shots, steal and deflect passes, and garner rebounds."
            count = 7
        }
        else if indexPath.row == 8 {
            posterPath = #imageLiteral(resourceName: "rules")
            overview.text = "Basketball is a team sport. Two teams of five players each try to score by shooting a ball through a hoop elevated 10 feet above the ground. The game is played on a rectangular floor called the court, and there is a hoop at each end. The court is divided into two main sections by the mid-court line. If the offensive team puts the ball into play behind the mid-court line, it has ten seconds to get the ball over the mid-court line. If it doesn't, thenthe defense gets the ball. Once the offensive team gets the ball over the mid-court line, it can no longer have possession of the ball in the area in back of the line. If it does, the defense is awarded the ball. "
            count = 8
        }
        
        let layout = UICollectionViewFlowLayout()
        
        let detailedView = DetailedController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: detailedView)
        navController.navigationBar.barTintColor = UIColor.rgb(red: 139, green: 69, blue: 19)
        
        detailedView.image_path = posterPath
        detailedView.overview = overview.text
        
        present(navController, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCellId", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        cell.titleLabel.text = title
        cell.titleLabel.textColor = UIColor.rgb(red: 139, green: 69, blue: 19)
        
        
        cell.overviewLabel.textColor = .lightGray
        self.tableView.separatorStyle = .singleLine
        
        cell.backgroundColor = UIColor.clear
        cell.layer.shadowColor = UIColor.white.cgColor
        
        print("row \(indexPath.row)")
        
        
        
        if indexPath.row == 0 {
            cell.posterLabel.image = #imageLiteral(resourceName: "stretch")
            cell.titleLabel.text = "Stretching"
            cell.posterLabel.contentMode = .scaleToFill
            cell.posterLabel.layer.cornerRadius = 16
            cell.posterLabel.layer.masksToBounds = true
            
        }
        else if indexPath.row == 1 {
            cell.posterLabel.image = #imageLiteral(resourceName: "warm up")
            cell.titleLabel.text = "Warm Up"
            cell.posterLabel.contentMode = .scaleToFill
            cell.posterLabel.layer.cornerRadius = 16
            cell.posterLabel.layer.masksToBounds = true
            
        }
        else if indexPath.row == 2 {
            cell.posterLabel.image = #imageLiteral(resourceName: "conditioning")
            cell.titleLabel.text = "Conditioning"
            cell.posterLabel.contentMode = .scaleToFill
            cell.posterLabel.layer.cornerRadius = 16
            cell.posterLabel.layer.masksToBounds = true
            
        }
        else if indexPath.row == 3 {
            cell.posterLabel.image = #imageLiteral(resourceName: "dribbling")
            cell.titleLabel.text = "Dribbling"
            cell.posterLabel.contentMode = .scaleToFill
            cell.posterLabel.layer.cornerRadius = 16
            cell.posterLabel.layer.masksToBounds = true
            
        }
        else if indexPath.row == 4 {
            cell.posterLabel.image = #imageLiteral(resourceName: "passing")
            cell.posterLabel.contentMode = .scaleToFill
            cell.titleLabel.text = "Passing"
            cell.posterLabel.layer.cornerRadius = 16
            cell.posterLabel.layer.masksToBounds = true
            
        }
        else if indexPath.row == 5 {
            cell.posterLabel.image = #imageLiteral(resourceName: "shooting")
            cell.posterLabel.contentMode = .scaleToFill
            cell.titleLabel.text = "Shooting"
            cell.posterLabel.layer.cornerRadius = 16
            cell.posterLabel.layer.masksToBounds = true
            
        }
        else if indexPath.row == 6 {
            cell.posterLabel.image = #imageLiteral(resourceName: "rebound")
            cell.posterLabel.contentMode = .scaleToFill
            cell.titleLabel.text = "Rebounding"
            cell.posterLabel.layer.cornerRadius = 16
            cell.posterLabel.layer.masksToBounds = true
            
        }
        else if indexPath.row == 7 {
            cell.posterLabel.image = #imageLiteral(resourceName: "defence")
            cell.titleLabel.text = "Defence"
            cell.posterLabel.contentMode = .scaleToFill
            cell.posterLabel.layer.cornerRadius = 16
            cell.posterLabel.layer.masksToBounds = true
            
        }
        else if indexPath.row == 8 {
            cell.posterLabel.image = #imageLiteral(resourceName: "rules")
            cell.titleLabel.text = "Rules"
            cell.posterLabel.contentMode = .scaleToFill
            cell.posterLabel.layer.cornerRadius = 16
            cell.posterLabel.layer.masksToBounds = true
            
        }
        
        cell.titleLabel.adjustsFontSizeToFitWidth = true
        cell.overviewLabel.adjustsFontSizeToFitWidth = true
        
        cell.titleLabel.numberOfLines = 0
        cell.overviewLabel.numberOfLines = 0
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @objc func handleChat() {
        let messagesController = MessagesController()
        messagesController.categoryController = self
        let navController = UINavigationController(rootViewController: messagesController)
        present(navController, animated: true, completion: nil)
    }
    
    func setupNavigationBar() {
        
        navigationItem.title = "Coach Nik"
        
        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 139, green: 69, blue: 19)
        //        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 245, green: 222, blue: 179), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25)]
        
    }
}



