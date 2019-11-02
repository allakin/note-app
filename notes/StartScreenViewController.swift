//
//  StartScreenViewController.swift
//  notes
//
//  Created by Pavel Anpleenko on 29/09/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func loginButton(_ sender: Any) {
    
    DispatchQueue.main.async {
        let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(login, animated: true, completion: nil)
    }
  }
  
  @IBAction func registrationButton(_ sender: Any) {
    DispatchQueue.main.async {
        let registration = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.present(registration, animated: true, completion: nil)
    }
  }
}
