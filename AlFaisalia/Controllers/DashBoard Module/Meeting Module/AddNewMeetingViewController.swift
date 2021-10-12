//
//  AddNewMeetingViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 19/01/1443 AH.
//

import UIKit

class AddNewMeetingViewController: UIViewController {

    @IBOutlet weak var participant_TableView: UITableView!
    
    @IBOutlet weak var formView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        formView.layer.borderWidth = 1
        formView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    

}

extension AddNewMeetingViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "inviteCell", for: indexPath)
            cell.selectionStyle = .none
//        let bgView : UIView = cell.viewWithTag(1)!
//        bgView.layer.borderWidth = 0.8
//        bgView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
//        bgView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.5))
        
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 90
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
        
       
    }
}
