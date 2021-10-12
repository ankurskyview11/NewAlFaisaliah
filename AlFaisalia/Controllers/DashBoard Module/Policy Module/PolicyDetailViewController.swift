//
//  PolicyDetailViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 20/01/1443 AH.
//

import UIKit

class PolicyDetailViewController: UIViewController {

    @IBOutlet weak var policyView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        policyView.layer.borderWidth = 1
        policyView.layer.borderColor = UIColor.lightGray.cgColor
    }
    

    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
}
