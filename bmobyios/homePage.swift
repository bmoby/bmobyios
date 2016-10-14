//
//  homePage.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 13/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import ParseFacebookUtilsV4
import FBSDKLoginKit

class homePage: UIViewController {
    
    // ############### THIS PAGE IS NOT THE REAL HOME PAGE THE CODE MOST TO BE COPIED ###############
    
    @IBAction func logoutFacebookClicked(sender: AnyObject) {
        
        PFUser.logOutInBackgroundWithBlock { (error:NSError?) in
            if error != nil {
                print(error!.localizedDescription)
            }else {
                let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("loginPage") as! connectionVC
                let homepages = UINavigationController(rootViewController: protectedPage)
                self.navigationController?.presentViewController(homepages, animated: true, completion: nil)
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
       
        let requestParameters = ["fields": "id, email, first_name, last_name"]
        let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        
        userDetails.startWithCompletionHandler { (connection, result, error:NSError!) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                let userFirstName = result.valueForKey("first_name")
                let userLastName = result.valueForKey("last_name")
                let userEmail = result.valueForKey("email")
                
                // Check if current user info exists in our DB
                let query = PFQuery(className: "_User")
                let verifyUser = user()
                query.whereKey("email", equalTo: userEmail!)
                query.findObjectsInBackgroundWithBlock({ (objects:[PFObject]?, error:NSError?) in
                    if error == nil {
                        for object in objects! {
                            verifyUser.email = object.valueForKey("email") as? String
                            verifyUser.firstName = object.valueForKey("firstName") as? String
                            verifyUser.lastName = object.valueForKey("lastName") as?  String
                        }
                        
                        print(verifyUser.email)
                        print(verifyUser.firstName)
                        print(verifyUser.lastName)
                        
                        // THERE IS THE BEGIN OF THE UPDATING USER INFO PROCESS
                        if (verifyUser.email == nil || verifyUser.firstName == nil || verifyUser.lastName == nil) {
                            
                            let thisUser = PFUser.currentUser()
                            if (userEmail != nil && verifyUser.email == nil)  {
                                thisUser!.setObject(userEmail!, forKey: "email")
                            }
                            if (userFirstName != nil && verifyUser.firstName == nil )  {
                                thisUser!.setObject(userFirstName!, forKey: "firstName")
                            }
                            if (userLastName != nil && verifyUser.lastName == nil)  {
                                thisUser!.setObject(userLastName!, forKey: "lastName")
                            }
                            
                            thisUser!.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) in
                                if error == nil {
                                    
                                    print("user was saved and updated")
                                } else {
                                    print(error!.localizedDescription)
                                }
                            })
                            
                        }// THERE IS THE END OF UPDATE PROCESS
                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
