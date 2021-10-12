//
//  FeelingPopUpViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 16/01/1443 AH.
//

import UIKit
import BottomPopup
import TagListView
class FeelingPopUpViewController: BottomPopupViewController {
    var height: CGFloat?
        var topCornerRadius: CGFloat?
        var presentDuration: Double?
        var dismissDuration: Double?
        var shouldDismissInteractivelty: Bool?
    
    
    override var popupHeight: CGFloat { return height ?? CGFloat(380) }
    
    override var popupTopCornerRadius: CGFloat { return topCornerRadius ?? CGFloat(40) }
    
    override var popupPresentDuration: Double { return presentDuration ?? 0.2 }
    
    override var popupDismissDuration: Double { return dismissDuration ?? 0.2 }
    
    @IBOutlet weak var texfFieldView: UIView!
    override var popupShouldDismissInteractivelty: Bool { return shouldDismissInteractivelty ?? true }
    
   
    @IBOutlet weak var feelingTagListView: TagListView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        texfFieldView.layer.borderWidth = 1
        texfFieldView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        feelingTagListView.delegate = self
        feelingTagListView.addTags(["Happy", "Motivated", "Sick", "Bored","Positive","Confused","Focused"])
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
       
    
    }
    

   
}
extension FeelingPopUpViewController: TagListViewDelegate{
    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}
