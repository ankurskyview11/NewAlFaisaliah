//
//  ToDoTaskListViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 15/01/1443 AH.
//

import UIKit
import FSCalendar
class ToDoTaskListViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate , UIGestureRecognizerDelegate {
  //  @IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var btnArrow: UIButton!
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var shortCalendarView: FSCalendar!
    @IBOutlet weak var taskListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        shortCalendarView.layer.cornerRadius = 20
        shortCalendarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        shortCalendarView.layer.borderWidth = 1
        shortCalendarView.layer.borderColor = UIColor.lightGray.cgColor
        shortCalendarView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.4))
       
        
        self.shortCalendarView.select(Date())
        
        self.view.addGestureRecognizer(self.scopeGesture)
        self.taskListTableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.shortCalendarView.scope = .week
        self.calendarHeightConstraint.constant = 400
        // For UITest
        self.shortCalendarView.accessibilityIdentifier = "calendar"
        
        
       
        
    }
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.shortCalendarView, action: #selector(self.shortCalendarView.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    deinit {
        print("\(#function)")
    }
    
    // MARK:- UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.taskListTableView.contentOffset.y <= -self.taskListTableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.shortCalendarView.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
   
    @IBAction func btnAction_AddNewTask(_ sender: Any) {
        let toDoList_VC = self.storyboard?.instantiateViewController(withIdentifier: "ToDoListViewController") as! ToDoListViewController
        
        toDoList_VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(toDoList_VC, animated: true)
        
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        print("CHANGE HEIGHT == \(bounds.height)")
        if bounds.height == 400.0{
            btnArrow.setImage(UIImage(named: "upSingleArrow"), for: .normal)
        }
        else{
            btnArrow.setImage(UIImage(named: "downSingleArrow"), for: .normal)
        }
        calendarHeightConstraint.constant = bounds.height
        // Do other updates here
        view.layoutIfNeeded()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
}

extension ToDoTaskListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskListCell", for: indexPath)
            cell.selectionStyle = .none
        let bgView : UIView = cell.viewWithTag(1)!
        bgView.layer.borderWidth = 0.8
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.4))
        
      //  let taskIndicatorView : UIView = cell.viewWithTag(2)!
//        taskIndicatorView.layer.borderWidth = 1
//        taskIndicatorView.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
//        let taskNameLbl : UILabel = cell.viewWithTag(3) as! UILabel
//        taskNameLbl.text = "Task Name"
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 170
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
        
       
    }
}
