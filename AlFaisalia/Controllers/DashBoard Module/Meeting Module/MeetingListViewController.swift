//
//  MeetingListViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 19/01/1443 AH.
//

import UIKit

class MeetingListViewController: UIViewController {

    @IBOutlet weak var meetingList_TableView: UITableView!
    @IBOutlet weak var btnCurrentMeeting: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var segmentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        segmentView.layer.borderWidth = 1
        segmentView.layer.borderColor = UIColor.lightGray.cgColor
        btnCurrentMeeting.layer.cornerRadius = 6
        btnCurrentMeeting.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        btnHistory.layer.cornerRadius = 6
        btnHistory.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    

    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAction_AddNewMeeting(_ sender: Any) {
        
        let addNewMeeting_VC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewMeetingViewController") as! AddNewMeetingViewController
        addNewMeeting_VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(addNewMeeting_VC, animated: true)
        
    }
    
    @IBAction func btnAction_MeetingHistory(_ sender: Any) {
    }
    
    @IBAction func btnAction_currentMeetingList(_ sender: Any) {
    }
}

extension MeetingListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "meetingCell", for: indexPath)
            cell.selectionStyle = .none
        let bgView : UIView = cell.viewWithTag(1)!
        bgView.layer.borderWidth = 0.8
        bgView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        bgView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.5))
        
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 130
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
        
       
    }
}
