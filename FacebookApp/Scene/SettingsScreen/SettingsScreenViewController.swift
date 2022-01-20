//
//  SettingsScreenViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SettingsScreenViewController: BaseViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFacebookProfileInfo()
        
    }
    
    func getFacebookProfileInfo() {
        let requestMe = GraphRequest.init(graphPath: "me", parameters: ["fields" : "id,name,email,picture.type(large)"])
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
                            print(data)
                            print(dictData["email"]!)
        
                            if let pictureURL = data["url"]{
                                if let url = URL(string: pictureURL as! String) {
                                    if let data = try? Data(contentsOf: url) { //here you get image data from url
                                        //generate image from data and assign it to your profile imageview
                                        self.userImage.image = UIImage(data: data)
                                        self.userImage.layer.cornerRadius = 10
                                    }
                                }
                            }
                        }
                    }
                }
            }
        })
        connection.start()
    }
    
}
