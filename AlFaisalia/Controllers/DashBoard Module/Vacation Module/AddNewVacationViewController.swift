//
//  AddNewVacationViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 13/01/1443 AH.
//

import UIKit
import DropDown
import WWCalendarTimeSelector
class AddNewVacationViewController: UIViewController, WWCalendarTimeSelectorProtocol{

    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var selectedIndex = -1
    var dateTitleLblArray = ["From","To"]
    var dateValueArray = ["",""]
    
    @IBOutlet weak var btnLeaveTpe: UIButton!
    let leaveDropDown = DropDown()
    var leaveTypeArray = ["Casual","Emergency","Sick","Maternity","Type1","Type2"]
    fileprivate var fromDate: Date = Date()
    fileprivate var toDate: Date = Date()
    
    var selector = WWCalendarTimeSelector.instantiate()
           
    @IBOutlet weak var btnTotalAppliedLeaves: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        formView.layer.borderWidth = 1
        formView.layer.borderColor = UIColor.lightGray.cgColor
        btnLeaveTpe.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        leaveDropDown.anchorView = btnLeaveTpe
        leaveDropDown.dataSource = leaveTypeArray
        leaveDropDown.bottomOffset = CGPoint(x: 0, y:( leaveDropDown.anchorView?.plainView.bounds.height)!)
        leaveDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.btnLeaveTpe.setTitle("\(item)", for: .normal)
            self.btnLeaveTpe.setImage(UIImage(systemName: "chevron.down"), for: .normal)
           
        }
        
      
                
        
        
    }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        
        print("SELECTED DATE ==> \(date.dateString())")
                   if selectedIndex == 0
                   {
                    self.dateValueArray[0] = date.dateString()
                    fromDate = date
       
                   }
                   else{
                    self.dateValueArray[1] = date.dateString()
                    toDate = date
       
                   }
        
        tableView.reloadData()
        if fromDate.dateString() != "" && toDate.dateString() != ""  {
            calculateDays(fromDate: fromDate, toDate: toDate)
        }
       
    }
    
    func calculateDays(fromDate:Date, toDate:Date) {
        let diffInDays = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day

        print(diffInDays!)
        if diffInDays! > 0
        {
            if diffInDays == 1
            {
            btnTotalAppliedLeaves.setTitle("Apply For \(diffInDays ?? 0) Day Leave", for: .normal)
            }
            else{
                btnTotalAppliedLeaves.setTitle("Apply For \(diffInDays ?? 0) Day Leaves", for: .normal)
            }
        }
        else{
            btnTotalAppliedLeaves.setTitle("Apply For 0 Day Leave", for: .normal)
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        selector = WWCalendarTimeSelector.instantiate()
        selector.delegate = self
        
        selector.optionCalendarBackgroundColorTodayFlash = UIColor(named: ACCENT_COLOR)!
        selector.optionTopPanelBackgroundColor = UIColor(named: ACCENT_COLOR)!
        selector.optionButtonFontColorCancel = UIColor(named: ACCENT_COLOR)!
        selector.optionButtonFontColorDone = UIColor(named: ACCENT_COLOR)!
        selector.optionSelectorPanelBackgroundColor = UIColor(named: ACCENT_COLOR)!

       
       
    }
    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnAction_selectLeaveType(_ sender: Any) {
        leaveDropDown.show()
        btnLeaveTpe.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        
        
    }
    
    @objc func openCalenderView(sender: UIButton) {
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
           let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        print("ROW == > \(indexPath?.row)")
        
        selectedIndex = indexPath!.row
        
//        RPicker.selectDate(title: "Select Date and Time", cancelText: "Cancel", datePickerMode: .dateAndTime, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
//                            // TODO: Your implementation for date
//            print("SELECTED DATE ==> \(selectedDate.dateString())")
//            if indexPath?.row == 0
//            {
//                self?.dateValueArray[0] = selectedDate.dateString()
//
//            }
//            else{
//                self?.dateValueArray[1] = selectedDate.dateString()
//
//            }
//            self?.tableView.reloadData()
//
//
//        })
       
        
        present(selector, animated: true, completion: nil)
  
        
   
    }

    
    @IBAction func btnAction_LeaveApply(_ sender: Any) {
    }
    
}
extension AddNewVacationViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            cell.selectionStyle = .none
        let dateLbl : UILabel = cell.viewWithTag(1) as!  UILabel
        let dateValueLbl : UIButton = cell.viewWithTag(2) as! UIButton
        
        dateLbl.text = dateTitleLblArray[indexPath.row]
    

        dateValueLbl.addTarget(self, action: #selector(openCalenderView), for: .touchUpInside)
        if dateValueArray.count > 0 {
            if dateValueArray[0] == "" && dateValueArray[1] == "" {
                dateValueLbl.setTitle(fromDate.dateString(), for: .normal)
            }
           
            else{
            dateValueLbl.setTitle(dateValueArray[indexPath.row], for: .normal)
            }
        }

        
      
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == selectedIndex {
//            return 400
//        }
//        else{
            return 95
     //   }
            
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
//        selectedIndex = indexPath.row
//        tableView.reloadData()
        
       

       
    }
}
extension Date {
    
    func dateString(_ format: String = "E, MMM-dd-YYYY, HH:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}
