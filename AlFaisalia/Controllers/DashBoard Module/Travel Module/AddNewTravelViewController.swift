//
//  AddNewTravelViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 19/01/1443 AH.
//

import UIKit

class AddNewTravelViewController: UIViewController {

    @IBOutlet weak var formView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        formView.layer.borderWidth = 1
        formView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
