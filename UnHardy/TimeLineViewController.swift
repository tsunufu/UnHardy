//
//  TimeLineViewController.swift
//  UnHardy
//
//  Created by ryo on 2022/09/17.
//

import UIKit

class TimeLineViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

   
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

  
    }
    
    @IBAction func photo() {
        MainTabBarController().didTapPlus()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
