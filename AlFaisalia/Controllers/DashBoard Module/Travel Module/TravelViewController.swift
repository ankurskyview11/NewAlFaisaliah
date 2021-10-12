//
//  TravelViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 19/01/1443 AH.
//

import UIKit

class TravelViewController: UIViewController {

    @IBOutlet weak var calendarView_HeightConst: NSLayoutConstraint!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var btnTrip: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    
    @IBOutlet weak var travelList_TableView: UITableView!
    
    @IBOutlet weak var btnFromDate: UIButton!
    
    @IBOutlet weak var dateSelector_StackView: UIStackView!
    @IBOutlet weak var btnToDate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calendarView_HeightConst.constant = 0
        dateSelector_StackView.isHidden = true
        segmentView.layer.borderWidth = 1
        segmentView.layer.borderColor = UIColor.lightGray.cgColor
        btnTrip.layer.cornerRadius = 6
        btnTrip.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        btnHistory.layer.cornerRadius = 6
        btnHistory.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        btnFromDate.addShadow(color: .lightGray)
        btnToDate.addShadow(color: .lightGray)
    }
    

    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func btnAction_TripHistory(_ sender: Any) {
        calendarView_HeightConst.constant = 90
        dateSelector_StackView.isHidden = false
    }
    @IBAction func btnAction_MyTrip(_ sender: Any) {
        calendarView_HeightConst.constant = 0
        dateSelector_StackView.isHidden = true
    }
    @IBAction func btnAction_addNewTravel(_ sender: Any) {
        let addNewTravel_VC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewTravelViewController") as! AddNewTravelViewController
        addNewTravel_VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(addNewTravel_VC, animated: true)
    }
    
}

extension TravelViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath)
            cell.selectionStyle = .none
        let bgView : UIView = cell.viewWithTag(1)!
        bgView.layer.borderWidth = 0.8
        bgView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
       // bgView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.5))
        
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 160
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
        
       
    }
}
