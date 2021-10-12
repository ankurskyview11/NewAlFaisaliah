//
//  PolicyViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 20/01/1443 AH.
//

import UIKit

class PolicyViewController: UIViewController {

    @IBOutlet weak var policyList_TableView: UITableView!
    
    @IBOutlet weak var policyType_CollectionView: UICollectionView!
    
   var selectedItem = 0
   var policyTypeArray = ["HR","IT","Operations","Others"]
    var policyTypeImageArray = [UIImage(named: "hr"), UIImage(named: "it"),UIImage(named: "Operations"),UIImage(named: "Other")]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    @IBAction func btnAction_Filter(_ sender: Any) {
    }
    
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func btnAction_Prev(_ sender: Any) {
        if selectedItem == 0 {
            
            selectedItem = 0
           
        }
        else{
            selectedItem -= 1
        }
        configureVisibleIndexPath(selectedIndex: selectedItem)
        
    }
    @IBAction func btnAction_Next(_ sender: Any) {
        print("SelectedItem == \(selectedItem)  === PolicyArray Count == \(policyTypeArray.count - 1)")
        if selectedItem == policyTypeArray.count - 1 {
       
            selectedItem = policyTypeArray.count - 1
        }
        else{
            selectedItem += 1
        }
        configureVisibleIndexPath(selectedIndex: selectedItem)
    }
    
    private func configureVisibleIndexPath(selectedIndex:Int) {

        print("SelectedIndex == \(selectedIndex)")
        policyType_CollectionView.scrollToItem(at: IndexPath(indexes: [0, selectedIndex]), at: .centeredHorizontally, animated: true)
        policyType_CollectionView.reloadData()
        
        
        

        }

}

extension PolicyViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "policyCell", for: indexPath)
            cell.selectionStyle = .none
        let bgView : UIView = cell.viewWithTag(1)!
        bgView.layer.borderWidth = 0.8
        bgView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        bgView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.5))
        let btnView : UIButton = cell.viewWithTag(2) as! UIButton
        btnView.layer.cornerRadius = 10
        btnView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        let releaseDate_lbl : UILabel = cell.viewWithTag(4) as! UILabel
        releaseDate_lbl.adjustsFontSizeToFitWidth = true
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 110
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
        let policyDetail_VC = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetailViewController") as! PolicyDetailViewController
        policyDetail_VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(policyDetail_VC, animated: true)
       
    }
}

extension PolicyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK:- UICollectionView Delegate Methods
    //MARK:-
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return policyTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
      
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "policyTypeCell", for: indexPath)
            
        let bgView : UIView = cell.viewWithTag(1)!

        bgView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.3))
//        let bgView : UIImageView = cell.viewWithTag(1) as! UIImageView
//        bgView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.3))
        let policyTypeTitle : UILabel = cell.viewWithTag(3) as! UILabel
        let policyTypeImage : UIImageView = cell.viewWithTag(2) as! UIImageView
        policyTypeImage.image = policyTypeImageArray[indexPath.item]
        policyTypeTitle.text = policyTypeArray[indexPath.item]
        if selectedItem == indexPath.item{
            bgView.layer.borderWidth = 1.5
             bgView.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
            policyTypeTitle.textColor = UIColor(named: ACCENT_COLOR)
        }
        else{
            bgView.layer.borderWidth = 0.0
            bgView.layer.borderColor = UIColor.clear.cgColor
            policyTypeTitle.textColor = UIColor.lightGray
        }
            return cell
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItem = indexPath.item
        policyType_CollectionView.reloadData()
            print(indexPath.item)
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: 90, height: 90)
       
    }
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        policyType_CollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    }
}
