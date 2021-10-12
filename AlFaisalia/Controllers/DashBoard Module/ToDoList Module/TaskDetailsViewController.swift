//
//  TaskDetailsViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 15/01/1443 AH.
//

import UIKit
import BottomPopup
class TaskDetailsViewController: UIViewController {

    @IBOutlet weak var taskListView: UIView!
    
    @IBOutlet weak var taskListTableView: UITableView!
    @IBOutlet weak var createTaskCircleView: UIView!
    @IBOutlet weak var createTaskView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        taskListView.layer.cornerRadius = 40
        taskListView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        taskListView.layer.borderWidth = 1
        taskListView.layer.borderColor = UIColor.lightGray.cgColor
        createTaskView.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        createTaskView.layer.borderWidth = 0.8
        createTaskCircleView.layer.borderWidth = 1
        createTaskCircleView.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        createTaskView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.5))
    }
    

    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func btnAction_addTask(_ sender: Any) {
        guard let popup_addTaskVC = storyboard?.instantiateViewController(withIdentifier: "AddTaskViewController") as? AddTaskViewController else { return }
        popup_addTaskVC.height = 525
        popup_addTaskVC.topCornerRadius = 30
        popup_addTaskVC.presentDuration = 0.2
        popup_addTaskVC.dismissDuration = 0.2
        popup_addTaskVC.popupDelegate = self
        
          present(popup_addTaskVC, animated: true, completion: nil)
    }
}

extension TaskDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
            cell.selectionStyle = .none
        let bgView : UIView = cell.viewWithTag(1)!
        bgView.layer.borderWidth = 0.8
        bgView.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        bgView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.5))
        
      //  let taskIndicatorView : UIView = cell.viewWithTag(2)!
//        taskIndicatorView.layer.borderWidth = 1
//        taskIndicatorView.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        let taskNameLbl : UILabel = cell.viewWithTag(3) as! UILabel
        taskNameLbl.text = "Task Name"
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 70
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
        
       
    }
}
extension TaskDetailsViewController: BottomPopupDelegate {
    
    func bottomPopupViewLoaded() {
        print("bottomPopupViewLoaded")
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {
        print("bottomPopupDidAppear")
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}
