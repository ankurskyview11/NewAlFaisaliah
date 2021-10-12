//
//  AccountViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 11/08/21.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var basicInfo_TableView: UITableView!
    
    @IBOutlet weak var btnProfileLinkedIn: UIButton!
    @IBOutlet weak var btnProfilePhone: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var btnProfileEmail: UIButton!
    @IBOutlet weak var basicInfoView: UIView!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    var basicInfoTitleArray = ["Designation","Department","Location","Company"]
    var basicInfoSubTitleArray = ["Developer","Development","Riyadh","Al Faisalia"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        basicInfoView.layer.borderWidth = 1
        basicInfoView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        
        profileView.layer.borderWidth = 0.5
        profileView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
        profileView.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        profileView.layer.masksToBounds = false
        profileView.layer.shadowOffset = CGSize(width: 0.0 , height: 4.0)
        profileView.layer.shadowOpacity = 1.0
        profileView.layer.shadowRadius = 1.0
        
        
        btnProfileEmail.layer.borderWidth = 1
        btnProfileEmail.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        btnProfileEmail.addShadow(color: UIColor.lightGray.withAlphaComponent(0.4))
        
        btnProfilePhone.layer.borderWidth = 1
        btnProfilePhone.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        btnProfilePhone.addShadow(color: UIColor.lightGray.withAlphaComponent(0.4))
        
        btnProfileLinkedIn.layer.borderWidth = 1
        btnProfileLinkedIn.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        btnProfileLinkedIn.addShadow(color: UIColor.lightGray.withAlphaComponent(0.4))
        
        
//        userProfileImage.layer.borderWidth = 0.2
//        userProfileImage.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        userProfileImage.addShadow(color: UIColor.lightGray.withAlphaComponent(0.2))
        
        
    }
    

  

}

extension AccountViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basicInfoTitleArray.count
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
            cell.selectionStyle = .none
        let lbl_title : UILabel = cell.viewWithTag(1) as! UILabel
        let lbl_subTitle : UILabel = cell.viewWithTag(2) as! UILabel
        lbl_title.text = basicInfoTitleArray[indexPath.row]
        lbl_subTitle.text = basicInfoSubTitleArray[indexPath.row]

     
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 44
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
        
       
    }
}
extension UIView {
func addBottomShadow() {
    layer.masksToBounds = false
    layer.shadowRadius = 2
    layer.shadowOpacity = 1
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOffset = CGSize(width: 0 , height: 2)
    layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                 y: bounds.maxY - layer.shadowRadius,
                                                 width: bounds.width,
                                                 height: layer.shadowRadius)).cgPath
}
}
