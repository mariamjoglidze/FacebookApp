//
//  SettingsScreenViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SettingsScreenViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFacebookProfileInfo()
        
    }
    
    func getFacebookProfileInfo() {
//        let requestMe = GraphRequest.init(graphPath: "me", parameters: ["fields" : "id,name,email,picture.type(large)"])
        let requestMe = GraphRequest(graphPath: "me",
                                        parameters: ["fields" : "id,name,email,picture.type(large)"],
                                        tokenString: "EAAHLlZCGjQWYBAF52pgi6eKMPzmQ6c13pt7OYjsxI2WoHtv31mPYWzVkUqXHF40C7iPhzMUcO5AZAeuHIB9zoZAkwGF58uZABnHY7iwCFm8jSZCqzLVmoJt1ZAwjqLZBWi7zhHZCELlQIh4zHpxrg7OIBTgQ6PHtC7Sk0vb9oo9ZA2ilLZAnpvD3UgOHeFdl1PmQ7JrKAuh9v8joBBPq0WGHzN",
                                        version: nil,
                                        httpMethod: .get)


        let connection = GraphRequestConnection()
        connection.add(requestMe, completion:{ (connectn, userresult, error) in
            
            if let dictData: [String : Any] = userresult as? [String : Any]
            {
                DispatchQueue.main.async
                {
                    if let pictureData: [String : Any] = dictData["picture"] as? [String : Any]
                    {
                        if let data : [String: Any] = pictureData["data"] as? [String: Any]
                        {
                            print(userresult)

                            if let pictureURL = data["url"]{
                                if let url = URL(string: pictureURL as! String) {
                                    if let data = try? Data(contentsOf: url) { //here you get image data from url
                                        //generate image from data and assign it to your profile imageview
                                        self.userImage.image = UIImage(data: data)
                                        self.userImage.layer.cornerRadius = self.userImage.bounds.width / 2
                                    }
                                }
                            }
                            
                            if let userName = dictData["name"]{
                                self.userNameLabel.text = userName as! String
                            }
                        }
                    }
                }
            }
        })
        connection.start()
    }
    
}
