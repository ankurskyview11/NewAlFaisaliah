//
//  AttendanceViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 20/01/1443 AH.
//

import UIKit

class AttendanceViewController: UIViewController {

    @IBOutlet weak var calendarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calendarView.layer.borderWidth = 1
        calendarView.layer.borderColor = UIColor.lightGray.cgColor
        calendarView.addShadow(color: .lightGray)
    }
    

    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
