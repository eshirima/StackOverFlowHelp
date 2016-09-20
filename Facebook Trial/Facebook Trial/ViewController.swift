//
//  ViewController.swift
//  Facebook Trial
//
//  Created by Emil Shirima on 9/19/16.
//  Copyright © 2016 Emil Shirima. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

struct FacebookPermission
{
    static let ID: String = "id"
    static let NAME: String = "name"
    static let EMAIL: String = "email"
    static let PROFILE_PIC: String = "picture"
    static let LAST_NAME: String = "last_name"
    static let FIRST_NAME: String = "first_name"
    static let USER_FRIENDS: String = "user_friends"
    static let PUBLIC_PROFILE: String = "public_profile"
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionLoginWithFacebook(_ sender: UIButton)
    {
        let facebookLogin: FBSDKLoginManager = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: [FacebookPermission.PUBLIC_PROFILE], from: self) { (facebookResult: FBSDKLoginManagerLoginResult?, error: Error?) in
            
            if let fbError = error
            {
                print("FB Login Error")
                print(fbError.localizedDescription)
            }
            else if let fbResult = facebookResult
            {
                print("***FB RESULT***")
                self.getFacebookData()
            }
        }
    }
    
    func getFacebookData()
    {
        let graphRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "\(FacebookPermission.NAME), \(FacebookPermission.FIRST_NAME), \(FacebookPermission.LAST_NAME), \(FacebookPermission.EMAIL), \(FacebookPermission.PROFILE_PIC).type(large)"])
        
        graphRequest.start { (connection: FBSDKGraphRequestConnection?, result: Any?, error: Error?) in
            
            if error == nil
            {
                
                // See the data before being casted
                print(result)
                
                if let facebookData = result as? NSDictionary
                {
                    print(facebookData) // From here you can see excatly how the JSON is structured hence allowing you to make the right casts.
                }
            }
            else
            {
                print("Facebook Graph Request Error")
                print(error!.localizedDescription)
            }
        }
    }
}
