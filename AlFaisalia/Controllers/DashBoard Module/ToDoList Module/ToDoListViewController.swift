//
//  ToDoListViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 10/01/1443 AH.
//

import UIKit
import FSCalendar
class ToDoListViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate , UIGestureRecognizerDelegate  {
    
    @IBOutlet weak var taskView: UIView!
    //@IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textV_TaskDescp: UITextView!
    @IBOutlet weak var textF_TaskName: UITextField!
    @IBOutlet weak var fileType_CollectionView: UICollectionView!
    
    @IBOutlet weak var taskDespView: UIView!
    @IBOutlet weak var taskNameView: UIView!
    
    var filesArray = [String]()
    
    @IBOutlet weak var shortCalendarView: FSCalendar!
    
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        taskView.layer.cornerRadius = 40
        taskView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        taskView.layer.borderWidth = 1
        taskView.layer.borderColor = UIColor.lightGray.cgColor
        taskView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.4))
        
        shortCalendarView.layer.cornerRadius = 20
        shortCalendarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        shortCalendarView.layer.borderWidth = 1
        shortCalendarView.layer.borderColor = UIColor.lightGray.cgColor
        shortCalendarView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.4))
       
        
        self.shortCalendarView.select(Date())
        
        self.view.addGestureRecognizer(self.scopeGesture)
       
        self.scrollView.panGestureRecognizer.require(toFail: self.scopeGesture)
       // self.fileType_CollectionView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.shortCalendarView.scope = .week
        self.calendarHeightConstraint.constant = 400
        // For UITest
        self.shortCalendarView.accessibilityIdentifier = "calendar"
        
        
        taskNameView.layer.cornerRadius = 10
        taskNameView.layer.borderWidth = 1
        taskNameView.layer.borderColor = UIColor.lightGray.cgColor
        
        taskDespView.layer.cornerRadius = 10
        taskDespView.layer.borderWidth = 1
        taskDespView.layer.borderColor = UIColor.lightGray.cgColor
        
        
      
        
        
        
        
        
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
        let shouldBegin = self.scrollView.contentOffset.y <= -self.scrollView.contentInset.top
        print(shouldBegin)
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            print(velocity)
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
    
   
    @IBAction func btnAction_AddFiles(_ sender: Any) {
        filesArray.append("File1")
        fileType_CollectionView.reloadData()
    }
    
    @IBAction func btnAction_CreateTask(_ sender: Any) {
        let taskDetail_VC = self.storyboard?.instantiateViewController(withIdentifier: "TaskDetailsViewController") as! TaskDetailsViewController
        taskDetail_VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(taskDetail_VC, animated: true)
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        print("HEIGHT CONST == \(bounds.height)")
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

extension ToDoListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK:- UICollectionView Delegate Methods
    //MARK:-
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return filesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
      
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "fileTypeCell", for: indexPath)
            //cell.backgroundColor = .green
            // Configure the cell
           
            return cell
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
            print(indexPath.item)
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: 80, height: 80)
       
    }
}
