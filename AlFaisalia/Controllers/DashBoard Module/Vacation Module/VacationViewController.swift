//
//  VacationViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 16/08/21.
//

import UIKit
import BottomPopup
class VacationViewController: UIViewController {

    @IBOutlet weak var vacationTableView: UITableView!
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    var isSelectedIndex = 0
  //  var filterArray = ["All", "Annual Leaves","Casual","Sick","Maternity"]
    var filterArray = ["All", "Annual Leaves"]
    
    @IBOutlet weak var filterBGView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        filterBGView.isHidden = true
        filterBGView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnAction_openFilter(_ sender: Any) {
        filterBGView.isHidden = false
    }
    
    
    @IBAction func btnAction_filterOK(_ sender: Any) {
        filterBGView.isHidden = true
    }
    
    @IBAction func btnAction_AddNewVacation(_ sender: Any) {
        
        let newVacation_VC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewVacationViewController") as! AddNewVacationViewController
        newVacation_VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(newVacation_VC, animated: true)
    }
    @IBAction func btnAction_showBalancedLeavesPopUp(_ sender: Any) {
        guard let popup_CheckOutVC = storyboard?.instantiateViewController(withIdentifier: "BalancedLeavePopUpViewController") as? BalancedLeavePopUpViewController else { return }
        popup_CheckOutVC.height = 300
        popup_CheckOutVC.topCornerRadius = 40
        popup_CheckOutVC.presentDuration = 0.2
        popup_CheckOutVC.dismissDuration = 0.2
        popup_CheckOutVC.popupDelegate = self
        
          present(popup_CheckOutVC, animated: true, completion: nil)
    }
}
extension VacationViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 12
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "vacationCell", for: indexPath)
            cell.selectionStyle = .none
        let bgView : UIView = cell.viewWithTag(1)!
        bgView.layer.borderWidth = 0.6
        bgView.layer.borderColor = UIColor.lightGray.cgColor
//        let monthLbl : UILabel = cell.viewWithTag(2) as! UILabel
//        let dateTimeLbl : UILabel = cell.viewWithTag(3) as! UILabel
//        let salaryLbl : UILabel = cell.viewWithTag(4) as! UILabel
//        let downloadBtn : UIButton = cell.viewWithTag(6) as! UIButton
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 130
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
        
       
    }
}

extension VacationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK:- UICollectionView Delegate Methods
    //MARK:-
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
      
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath)
            //cell.backgroundColor = .green
            // Configure the cell
        let bgView : UIView = cell.viewWithTag(1)!
        let filterLbl : UILabel = cell.viewWithTag(2) as! UILabel
        
        if isSelectedIndex == indexPath.item {
            bgView.backgroundColor = .white
            filterLbl.text = "• \(filterArray[indexPath.item])"
           // bgView.addShadow(color: UIColor.darkGray.withAlphaComponent(0.5))
            filterLbl.textColor = UIColor(named: ACCENT_COLOR)
            filterLbl.font = UIFont(name: "Avenir-Heavy", size: 17)
        }
        else{
            bgView.backgroundColor = .clear
            filterLbl.text = "\(filterArray[indexPath.item])"
           // bgView.addShadow(color: .clear)
            filterLbl.textColor = UIColor.lightGray
            filterLbl.font = UIFont(name: "Avenir-Book", size: 17)
        }
            return cell
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
            print(indexPath.item)
        
        isSelectedIndex = indexPath.item
      
        filterCollectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: 140, height: 50)
       
    }
   
}
extension VacationViewController: BottomPopupDelegate {
    
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
