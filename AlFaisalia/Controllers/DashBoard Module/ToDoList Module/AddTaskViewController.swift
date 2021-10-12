//
//  AddTaskViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 15/01/1443 AH.
//

import UIKit
import BottomPopup

class AddTaskViewController: BottomPopupViewController {
    var height: CGFloat?
        var topCornerRadius: CGFloat?
        var presentDuration: Double?
        var dismissDuration: Double?
        var shouldDismissInteractivelty: Bool?
    
    
    override var popupHeight: CGFloat { return height ?? CGFloat(525) }
    
    override var popupTopCornerRadius: CGFloat { return topCornerRadius ?? CGFloat(30) }
    
    override var popupPresentDuration: Double { return presentDuration ?? 0.2 }
    
    override var popupDismissDuration: Double { return dismissDuration ?? 0.2 }
    
    override var popupShouldDismissInteractivelty: Bool { return shouldDismissInteractivelty ?? true }
  
    
    @IBOutlet weak var assignedPersonTableView: UITableView!
    @IBOutlet weak var textV_TaskDescp: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textV_TaskDescp.layer.cornerRadius = 10
        textV_TaskDescp.layer.borderColor = UIColor.lightGray.cgColor
        textV_TaskDescp.layer.borderWidth = 1
        textV_TaskDescp.addShadow(color: UIColor.lightGray.withAlphaComponent(0.4))
    }
    
    @IBAction func btnAction_HidePopUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnAction_TaskCompleted(_ sender: Any) {
        print("Task Completed")
    }
    

    @IBAction func btnAction_TaskCancel(_ sender: Any) {
        print("Task Cancel")
    }
    @IBAction func btnAction_TaskInProgress(_ sender: Any) {
        print("Task In Progress")
    }
    
    @IBAction func btnAction_AddPeople(_ sender: Any) {
        print("Add People")
    }
    
    @IBAction func btnAction_submitTask(_ sender: Any) {
        print("Submit Task")
    }
}

extension AddTaskViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "assignCell", for: indexPath)
            cell.selectionStyle = .none
        
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 70
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
        
       
    }
}
