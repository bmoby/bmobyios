//
//  user.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 09/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import Foundation


class user{
    
    let lang = language()
    var email:String?
    var password:String?
    var phone:String?
    var firstName:String?
    var lastName:String?
    var birthDate:String?
    var gender:String?
    var avatar:UIImageView?
    var languages = [language]()
    var nationality:String?
    var profession:String?
    var music:String?
    var aboutMe:String?
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* USER CLASS METHODS *********************************
    
    
    
    // Function to call when the user have to be saved in the DB
    func save(){
        let object = PFUser()
        let image = UIImageJPEGRepresentation(self.avatar!.image!, 0.5)
        let imageFile = PFFile(name: "img1", data: image!)
            object["email"] = self.email
            object.username = self.email
            object["password"] = self.password
            object["phone"] = self.phone
            object["firstName"] = self.firstName
            object["lastName"] = self.lastName
            object["birthDate"] = self.birthDate
            object["avatar"] = imageFile
            object["nationality"] = self.nationality
            object["profession"] = self.profession
            object["music"] = self.music
            object["aboutMe"] = self.aboutMe
        
        
        // Saving the selected languages by the user
        if self.languages.count > 0{
            object["language01"] = self.languages[0].name
        }
        if self.languages.count > 1{
            object["language02"] = self.languages[1].name
        }
        if self.languages.count > 2{
            object["language03"] = self.languages[2].name
        }
        if self.languages.count > 3{
            object["language04"] = self.languages[3].name
        }
        if self.languages.count > 4{
            object["language05"] = self.languages[4].name
        }
        if self.languages.count > 5{
            object["language06"] = self.languages[5].name
        }
        if self.languages.count > 6{
            object["language07"] = self.languages[6].name
        }
        if self.languages.count > 7{
            object["language08"] = self.languages[7].name
        }
        if self.languages.count > 8{
            object["language09"] = self.languages[8].name
        }
        if self.languages.count > 9{
            object["language10"] = self.languages[9].name
        }

        
        // saving the object in the DB
        object.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) in
            if error == nil {
                print("User signed up and record has beed created in DB")
            } else {
                print("We got bad news! Cannot register this user there is a problems")
                print(error!.localizedDescription)
            }
        }
    }
}
