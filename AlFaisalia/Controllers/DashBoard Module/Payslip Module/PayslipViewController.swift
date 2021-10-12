//
//  PayslipViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 14/08/21.
//

import UIKit
import DropDown
import WWCalendarTimeSelector
import AFNetworking
class PayslipViewController: UIViewController, WWCalendarTimeSelectorProtocol {

    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var payslipTableView: UITableView!
    
    @IBOutlet weak var payslipDetail_BGView: UIView!
    
    @IBOutlet weak var btnYear: UIButton!
    let yearDropDown = DropDown()
    
    var yearArray = [String]()
    var monthStringArray = ["January","February","March","April","May","June","July","August","September","October","November","December"]
   
    var bgView = UIView()
    
    @IBOutlet weak var dateSelectorBGView: UIView!
    
    var selector = WWCalendarTimeSelector.instantiate()
 
    var paySlipDataArray = [[String:Any]]()
    var paySlipHeaderArray = [String]()
    
    var cMonth = ""
    var cYear = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        payslipDetail_BGView.isHidden = true
        payslipDetail_BGView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        dateSelectorBGView.addShadow(color: .lightGray)
        
//        let currentYear = Calendar.current.component(.year, from: Date())
//        btnYear.setTitle("\(currentYear)", for: .normal)
//        for i in 1990...currentYear {
//            yearArray.append("\(i)")
//            print("Year => \(i)")
//        }
        yearDropDown.anchorView = btnYear
        yearDropDown.dataSource = yearArray.reversed()
        yearDropDown.bottomOffset = CGPoint(x: 0, y:(yearDropDown.anchorView?.plainView.bounds.height)!)
        yearDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.btnYear.setTitle("\(item)", for: .normal)
            arrowImage.image = UIImage(systemName: "arrowtriangle.down.fill")
           
        }
        
        getPaySlipData(withEmpID: "\(UserDefaults.standard.object(forKey: "EEmployeeNo") ?? "")", month: "", year: "2021")
        
    }
    
    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAction_closeDetailView(_ sender: Any) {
        payslipDetail_BGView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
//        selector = WWCalendarTimeSelector.instantiate()
//        selector.delegate = self
//        selector.optionStyles.showDateMonth(false)
//        selector.optionStyles.showMonth(true)
//        selector.optionStyles.showYear(true)
//        selector.optionStyles.showTime(false)
//        selector.optionCalendarBackgroundColorTodayFlash = UIColor(named: ACCENT_COLOR)!
//        selector.optionTopPanelBackgroundColor = UIColor(named: ACCENT_COLOR)!
//        selector.optionButtonFontColorCancel = UIColor(named: ACCENT_COLOR)!
//        selector.optionButtonFontColorDone = UIColor(named: ACCENT_COLOR)!
//        selector.optionSelectorPanelBackgroundColor = UIColor(named: ACCENT_COLOR)!

       
       
    }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        
//        print("SELECTED DATE ==> \(date.dateString())")
//                   if selectedIndex == 0
//                   {
//                    self.dateValueArray[0] = date.dateString()
//                    fromDate = date
//       
//                   }
//                   else{
//                    self.dateValueArray[1] = date.dateString()
//                    toDate = date
//       
//                   }
//        
//        tableView.reloadData()
//        if fromDate.dateString() != "" && toDate.dateString() != ""  {
//            calculateDays(fromDate: fromDate, toDate: toDate)
//        }
       
    }
    @IBAction func btnAction_selectYear(_ sender: Any) {
        //Mehod for only Year drop down
//        yearDropDown.show()
//
        
        // First Method for Month/Year Picker
            arrowImage.image = UIImage(systemName: "arrowtriangle.up.fill")
        bgView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        self.view.addSubview(bgView)
        AKMonthYearPickerView.sharedInstance.barTintColor =  UIColor(named: ACCENT_COLOR)!

        AKMonthYearPickerView.sharedInstance.show(vc: self, doneHandler: doneHandler, completetionalHandler: completetionalHandler(month:year:))
        
        
        //Second Method for Month/Year Calendar
        
       // present(selector, animated: true, completion: nil)

       
    }
    private func doneHandler() {
        print("Month picker Done button action")
        arrowImage.image = UIImage(systemName: "arrowtriangle.down.fill")
        bgView.removeFromSuperview()
        getPaySlipData(withEmpID: "\(UserDefaults.standard.object(forKey: "EEmployeeNo") ?? "")", month: "\(cMonth)", year: "\(cYear)")

    }
    
    private func completetionalHandler(month: Int, year: Int) {
        print( "month = ", month, " year = ", year )
        
        btnYear.setTitle("\(monthStringArray[month-1]), \(year)", for: .normal)
        print(month)
        cMonth = "\(month)"
         cYear = "\(year)"

    }
    
    
    func getPaySlipData(withEmpID:String,month:String, year:String) {
        paySlipDataArray = [[String:Any]]()
        paySlipHeaderArray = [String]()
        supportingfuction.showProgressHud("Please Wait...", labelText: "Processing Request!")
        /*
         "I_PERNR": "00000248",
         "I_MONTH":"04",
         "I_YEAR":"2020",
         "login":"RFCWEBXWI100",
         "password":"test2ECP"*/
        let parameters = ["I_USERID":"",
                          "I_PERNR": withEmpID,
                          "I_MONTH":month,
                          "I_YEAR":year,
                          "login":"RFCWEBXWI100",
                          "password":"test2ECP"]
       
      print("PARAMS ===> \(parameters)")
        let url = "https://app.nupco.com/ldap/payroll.php"
        print(url)
       
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as? Set<String>
        manager.post(url, parameters: parameters, headers: nil, progress: nil, success: {
            (operation, responseObject) in
            if let dict = responseObject as? NSDictionary {
                supportingfuction.hideProgressHudInView()
               // print(dict)
              
        
                let str = dict["success"] as? Int
                if (str == 1) {
                    print("ok")
                   
            
                    if let dataDict = dict["data"] as? [String:Any] {
                        
                        if let subDataDict = dataDict["T_FINAL"] as? [String:Any]{
                          
                            
                            
                           
                            
                            if let items = subDataDict["item"] as? [[String:Any]]{
                              
                                for i in 0...items.count - 1 {
                                    self.paySlipHeaderArray.append(items[i]["MONTH"] as! String)
                                    self.paySlipDataArray.append(items[i]["LINE"] as! [String : Any])
                                   
                                }
                                
                               print("MAIN PAYSLIP DATA ====> \(self.paySlipDataArray)")
                                print("MAIN PAYSLIP DATA COUNT====> \(self.paySlipDataArray.count)")

                                
                                if self.paySlipDataArray.count > 0 {
                                    for j in 0...self.paySlipDataArray.count - 1 {
                                        print("LOOP First",j)
                                    if let subItems = self.paySlipDataArray[j]["item"] as? [[String:Any]] {
                                        
                                       // for k in 0...subItems.count - 1 {
                                         //   print("LOOP Second",k, "ON First",j)
                                            
                                            //a.insert(6, atIndex:2)
                                           // self.itemsArray.insert(subItems[k], at: j)
                                          //  self.itemsArray.append(contentsOf: subItems)
//
//                                            print("DATE ===> \(self.itemsArray[j]["PAYROLL_DATE"] ?? "NO DATA")")
//                                            print("AMOUNT ===> \(self.itemsArray[j]["AMOUNT"] ?? "NO DATA")")
                                     //   }
                                        
                                    }
                                    }
                                }
                              //  print("PAYSLIP sub item ==> \(self.itemsArray)")
                            //    print("PAYSLIP sub item count ==> \(self.itemsArray.count)")
                              
//                                if self.itemsArray.count > 0 {
//                                    for k in 0...self.itemsArray.count - 1 {
//                                        print("DATE ===> \(self.itemsArray[8]["PAYROLL_DATE"] ?? "NO DATA")")
//                                        print("AMOUNT ===> \(self.itemsArray[8]["AMOUNT"] ?? "NO DATA")")
//
//                                    }
//                                }
                            }
                            
                        }
                    }
                    
                   
                   
                    self.payslipTableView.reloadWithAnimation()
                   
                }
                else
                {
                    
                    print("SOMETHING WENT WRONG")
                    let msg = dict["msg"] as? String
                    self.view.makeToast(msg)
                    
                    
                }
               
            }
        }, failure: {
            (operation, error) in
            supportingfuction.hideProgressHudInView()
            print("Error: " + error.localizedDescription)
           
           
        })
    }
    func formatMonthString(withMonthNumber:String) -> String {
        switch withMonthNumber {
        case "01":
            return "JANUARY"
        case "02":
            return "FEBRUARY"
        case "03":
            return "MARCH"
        case "04":
            return "APRIL"
        case "05":
            return "MAY"
        case "06":
            return "JUNE"
        case "07":
            return "JULY"
        case "08":
            return "AUGUST"
        case "09":
            return "SEPTEMBER"
        case "10":
            return "OCTOBER"
        case "11":
            return "NOVEMBER"
        case "12":
            return "DECEMBER"
        default:
            return ""
        }
    }
}

extension PayslipViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return paySlipDataArray.count
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "payslipCell", for: indexPath) 
            cell.selectionStyle = .none
        let bgView : UIView = cell.viewWithTag(1)!
        bgView.layer.borderWidth = 0.6
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        let monthLbl : UILabel = cell.viewWithTag(2) as! UILabel
        let dateTimeLbl : UILabel = cell.viewWithTag(3) as! UILabel
        let salaryLbl : UILabel = cell.viewWithTag(4) as! UILabel
//        let downloadBtn : UIButton = cell.viewWithTag(6) as! UIButton
        
        monthLbl.text = formatMonthString(withMonthNumber: paySlipHeaderArray[indexPath.row])
        if let  tempDict = self.paySlipDataArray[indexPath.row]["item"] as? [[String:Any]]
        {
            print("DATE == \(tempDict[0]["PAYROLL_DATE"] ?? "")")
            dateTimeLbl.text = "\(tempDict[0]["PAYROLL_DATE"] ?? "")"
            salaryLbl.text = "\(tempDict[0]["AMOUNT"] ?? "") SAR"
        }
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 130
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        payslipDetail_BGView.isHidden = false
        
        bgView.removeFromSuperview()
    }
}
extension UITableView {

    func reloadWithAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        for cell in cells {
            UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
