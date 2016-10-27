//
//  homePageVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 23/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class homePageVC: UIViewController, SendSelectedCityToHome, UITabBarControllerDelegate {

    
    
    var searchInCity:String?
    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************
    
    
    
    @IBOutlet weak var searchCity: UILabel!
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if searchInCity != nil {
            
            self.searchCity.text = self.searchInCity
        }else{
            
            self.searchCity.text = "Current Location"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.delegate = self
    }

    
    // -----------------------------------------------------------------------------------
    //******************************* DELEGATE METHOD ************************************
    
    
    
    func userDidSelectACity(data: String) {
        self.searchInCity = data
        print(data)
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* TABBAR METHODS *************************************
    
    
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if viewController != self {
            let controller = viewController as! UINavigationController
            let page = controller.viewControllers.first as! checkVC
            page.delegate = self
            print("homePageVC: switch to checkVC with tabBar")
        } else {
            print("homePageVC: Back to homePage with tabBar")
        }
        
    }

}
