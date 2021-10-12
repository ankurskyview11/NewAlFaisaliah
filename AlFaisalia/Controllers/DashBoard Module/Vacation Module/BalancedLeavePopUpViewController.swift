//
//  BalancedLeavePopUpViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 10/01/1443 AH.
//

import UIKit
import BottomPopup
class BalancedLeavePopUpViewController: BottomPopupViewController {
    var height: CGFloat?
        var topCornerRadius: CGFloat?
        var presentDuration: Double?
        var dismissDuration: Double?
        var shouldDismissInteractivelty: Bool?
    
    
    override var popupHeight: CGFloat { return height ?? CGFloat(300) }
    
    override var popupTopCornerRadius: CGFloat { return topCornerRadius ?? CGFloat(40) }
    
    override var popupPresentDuration: Double { return presentDuration ?? 0.2 }
    
    override var popupDismissDuration: Double { return dismissDuration ?? 0.2 }
    
    override var popupShouldDismissInteractivelty: Bool { return shouldDismissInteractivelty ?? true }
    
    @IBOutlet weak var lbl_leaveUsed: UILabel!
    
    @IBOutlet weak var progressView: JKCircleView!
    @IBOutlet weak var lbl_totalLeaveAccured: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    @IBAction func btnAction_HideView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setStaticView()
    }
    
    func setStaticView() {
        progressView.animationDuration = 1
        progressView.lineWidth = 8
        progressView.animateCircle(angle: 0.5)//====Percentage
        progressView.isToRemoveLayerAfterCompletion = false
      

    }
  
}
