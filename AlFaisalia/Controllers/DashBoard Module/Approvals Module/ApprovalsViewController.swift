//
//  ApprovalsViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 20/01/1443 AH.
//

import UIKit

class ApprovalsViewController: UIViewController {

    @IBOutlet weak var filterBG: UIView!
    @IBOutlet weak var segmentedCntrl: UISegmentedControl!
    @IBOutlet weak var approvalList_TableView: UITableView!
    
    @IBOutlet weak var btnVacationType: UIButton!
    
    @IBOutlet weak var btnApprovalType: UIButton!
    
    @IBOutlet weak var btnFromDate: UIButton!
    
    @IBOutlet weak var btnToDate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        segmentedCntrl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        segmentedCntrl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        filterBG.isHidden = true
        filterBG.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        btnFromDate.addShadow(color: .lightGray)
        btnToDate.addShadow(color: .lightGray)
        
        btnApprovalType.layer.borderWidth = 1
        btnApprovalType.layer.borderColor = UIColor.lightGray.cgColor
        btnApprovalType.layer.cornerRadius = 4
        btnApprovalType.addShadow(color: .lightGray)
        
        btnVacationType.layer.borderWidth = 1
        btnVacationType.layer.borderColor = UIColor.lightGray.cgColor
        btnVacationType.layer.cornerRadius = 4
        btnVacationType.addShadow(color: .lightGray)
        
    }
    
    
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func btnAction_Filter(_ sender: Any) {
        filterBG.isHidden = false
    }
    @IBAction func btnAction_SearchResult(_ sender: Any) {
        filterBG.isHidden = true
    }
    
}

extension ApprovalsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "approvalCell", for: indexPath)
            cell.selectionStyle = .none
        let bgView : UIView = cell.viewWithTag(1)!
        bgView.layer.borderWidth = 0.8
        bgView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        bgView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.5))
//        let btnView : UIButton = cell.viewWithTag(2) as! UIButton
//        btnView.layer.cornerRadius = 10
//        btnView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
//        let releaseDate_lbl : UILabel = cell.viewWithTag(4) as! UILabel
//        releaseDate_lbl.adjustsFontSizeToFitWidth = true
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 150
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
    
       
    }
}
