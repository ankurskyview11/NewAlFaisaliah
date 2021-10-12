//
//  HomeViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 11/08/21.
//

import UIKit
import FSPagerView
import BottomPopup
class HomeViewController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {
    
    @IBOutlet weak var dashboardCollectionView: UICollectionView!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = 3
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
            self.pageControl.setStrokeColor(UIColor(named: ACCENT_COLOR), for: .normal)
            self.pageControl.setStrokeColor(UIColor(named: ACCENT_COLOR), for: .selected)
            self.pageControl.setFillColor(UIColor(named: ACCENT_COLOR), for: .selected)
            
            
        }
    }
    
    @IBOutlet weak var tips_lbl: UILabel!
    //MAIN
   // var dashboardItemArray = ["To-Do List", "Payslip","Meeting","Travel","Directory","Attendance","Approvals","Health","Vacation","Policies","My Staff"]
    //var dashboardItemImageArray = [UIImage(named: "todolist"),UIImage(named: "payslip"),UIImage(named: "meeting"),UIImage(named: "travel"),UIImage(named: "directory"),UIImage(named: "attendance"),UIImage(named: "approval"),UIImage(named: "health"),UIImage(named: "vacation"),UIImage(named: "policy"),UIImage(named: "myStaff")]
    
    var tipsArray = ["Try to be a rainbow in someone's cloud.", "Honesty is the best policy","A positive mindset brings positive things."]
    
    @IBOutlet weak var lbl_username: UILabel!

    
// TEMPORARY
    var dashboardItemArray = [ "Payslip","Health", "Attendance","Policy","Vacation"]
     var dashboardItemImageArray = [UIImage(named: "payslip"),UIImage(named: "health"), UIImage(named: "attendance"),UIImage(named: "policy"),UIImage(named: "vacation")]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.view.makeToast("Login Successfully")
        lbl_username.text = "\(UserDefaults.standard.object(forKey: "EEmployeeName") ?? "")"

        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
    }
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }
        
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        //cell.imageView?.image = UIImage(named: "tips")
      //  cell.imageView?.image = imageWithImage(image: UIImage(named: "tips2")!, scaledToSize: CGSize(width: 200, height: 80))
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.imageView?.image = UIImage(named: "tips")
       //cell.textLabel?.text = "Honesty is the best policy."
        //cell.textLabel?.adjustsFontSizeToFitWidth = true
//        cell.textLabel?.font = UIFont(name: "Avenir", size: 15.0)
//
//        cell.textLabel?.numberOfLines = 2
//        cell.textLabel?.textColor = .black
//        cell.textLabel?.textAlignment = .center
        
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0 ,y: 0 ,width: newSize.width ,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)

    }
       
    /*func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool
    {
        return false
    }
    func pagerView(_ pagerView: FSPagerView, didHighlightItemAt index: Int)
    {
        
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int)
    {
        
    }
    func pagerView(_ pagerView: FSPagerView, shouldSelectItemAt index: Int) -> Bool
    {
        return false
    }
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int)
    {
        
    }
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int)
    {
        
    }
    func pagerViewWillBeginDragging(_ pagerView: FSPagerView)
    {
        
    }
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int)
    {
        
    }*/
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int)
    {
        self.pageControl.currentPage = index
        self.tips_lbl.text = "\u{22}\(tipsArray[index])\u{22}"
    }
    
    // MARK:- FSPagerViewDelegate
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
        self.tips_lbl.text = "\u{22}\(tipsArray[targetIndex])\u{22}"
    }
    
    @IBAction func btnAction_TellUsYourFeelings(_ sender: Any) {
        
        guard let popup_FeelingVC = storyboard?.instantiateViewController(withIdentifier: "FeelingPopUpViewController") as? FeelingPopUpViewController else { return }
        popup_FeelingVC.height = 380
        popup_FeelingVC.topCornerRadius = 40
        popup_FeelingVC.presentDuration = 0.2
        popup_FeelingVC.dismissDuration = 0.2
        popup_FeelingVC.popupDelegate = self
        
          present(popup_FeelingVC, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK:- UICollectionView Delegate Methods
    //MARK:-
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return dashboardItemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
      
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath)
            //cell.backgroundColor = .green
            // Configure the cell
            let iconBGView : UIView = cell.viewWithTag(1)!
            let dashboardItemImage : UIImageView = cell.viewWithTag(2) as! UIImageView
            let dashboardItemTitle : UILabel = cell.viewWithTag(3) as! UILabel
        iconBGView.layer.borderWidth = 1
        iconBGView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        iconBGView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.5))
        dashboardItemTitle.text = dashboardItemArray[indexPath.item]
        dashboardItemImage.image = dashboardItemImageArray[indexPath.item]
            return cell
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
            print(indexPath.item)
        if indexPath.item == 0{
            print("ToDo List")
//            let toDoTaskList_VC = self.storyboard?.instantiateViewController(withIdentifier: "ToDoTaskListViewController") as! ToDoTaskListViewController
//            toDoTaskList_VC.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(toDoTaskList_VC, animated: true)
            
            //Temp
            let payslip_VC = self.storyboard?.instantiateViewController(withIdentifier: "PayslipViewController") as! PayslipViewController
            payslip_VC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(payslip_VC, animated: true)
            
        }
        else if indexPath.item == 1{
            print("Payslip")
//            let payslip_VC = self.storyboard?.instantiateViewController(withIdentifier: "PayslipViewController") as! PayslipViewController
//            payslip_VC.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(payslip_VC, animated: true)
            
            //Temp
            let health_VC = self.storyboard?.instantiateViewController(withIdentifier: "HealthViewController") as! HealthViewController
            health_VC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(health_VC, animated: true)
            
        }
        else if indexPath.item == 2{
            print("Meeting")
//            let meeting_VC = self.storyboard?.instantiateViewController(withIdentifier: "MeetingListViewController") as! MeetingListViewController
//            meeting_VC.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(meeting_VC, animated: true)
            
            let attendance_VC = self.storyboard?.instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
            attendance_VC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(attendance_VC, animated: true)
        }
        else if indexPath.item == 3{
            print("Travel")
//            let travel_VC = self.storyboard?.instantiateViewController(withIdentifier: "TravelViewController") as! TravelViewController
//            travel_VC.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(travel_VC, animated: true)
            
            let policy_VC = self.storyboard?.instantiateViewController(withIdentifier: "PolicyViewController") as! PolicyViewController
            policy_VC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(policy_VC, animated: true)
        }
        else if indexPath.item == 4{
            print("Directoryw")
//            let directory_VC = self.storyboard?.instantiateViewController(withIdentifier: "DirectoryViewController") as! DirectoryViewController
//            directory_VC.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(directory_VC, animated: true)
            
            let vacation_VC = self.storyboard?.instantiateViewController(withIdentifier: "VacationViewController") as! VacationViewController
            vacation_VC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vacation_VC, animated: true)
        }
        else if indexPath.item == 5{
            print("Attendance")
            let attendance_VC = self.storyboard?.instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
            attendance_VC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(attendance_VC, animated: true)
        }
        else if indexPath.item == 6{
            print("Approvals")
            let approvals_VC = self.storyboard?.instantiateViewController(withIdentifier: "ApprovalsViewController") as! ApprovalsViewController
            approvals_VC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(approvals_VC, animated: true)
        }
        else if indexPath.item == 7{
            print("Health")
        let health_VC = self.storyboard?.instantiateViewController(withIdentifier: "HealthViewController") as! HealthViewController
        health_VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(health_VC, animated: true)
            
        }
        else if indexPath.item == 8{
            print("Vacation")
            let vacation_VC = self.storyboard?.instantiateViewController(withIdentifier: "VacationViewController") as! VacationViewController
            vacation_VC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vacation_VC, animated: true)
            
        }
        else if indexPath.item == 9{
            print("Policy")
            let policy_VC = self.storyboard?.instantiateViewController(withIdentifier: "PolicyViewController") as! PolicyViewController
            policy_VC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(policy_VC, animated: true)
        }
        else if indexPath.item == 10{
            print("My Staff")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: 120, height: 130)
       
    }
}
extension HomeViewController: BottomPopupDelegate {
    
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
