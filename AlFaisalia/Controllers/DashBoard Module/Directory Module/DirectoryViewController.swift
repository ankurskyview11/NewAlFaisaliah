//
//  DirectoryViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 16/01/1443 AH.
//

import UIKit

class DirectoryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var directoryListTableView: UITableView!
    
    var empDictionary = [String: [String]]()
    var empSectionTitles = [String]()
    var employeeList = [String]()
    var filterEmployeeList = [String]()
    
    var isSearch = false
   
    @IBOutlet weak var searchView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        employeeList = ["Ankur", "Arun","Ajay", "Bhola", "Brij Kishore","Chandra", "Colwin","Chamma","Danish","Dharmendra", "Devendra","Faiz", "Farooq","Fatima","Hitesh","Jagdish","Kavish","Khusboo","Leena","Manoj", "Mukesh","Mohd Zubair","Nirbhay","Nishikant","Natalia","Pawan","Pankaj","Patrick","Raj","Ramesh","Robert","Tom","Vijay","Zakeer"]
        
        for emp in employeeList {
               let empKey = String(emp.prefix(1))
                   if var empValues = empDictionary[empKey] {
                    empValues.append(emp)
                    empDictionary[empKey] = empValues
                   } else {
                    empDictionary[empKey] = [emp]
                   }
           }
        
        empSectionTitles = [String](empDictionary.keys)
        empSectionTitles = empSectionTitles.sorted(by: { $0 < $1 })
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.lightGray.cgColor
        searchView.addShadow(color: .lightGray)
        directoryListTableView.sectionIndexColor = .gray
    }
    
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    //MARK:- UITextField Delegate Method
    //MARK:-
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchString = textField.text
        print(searchString!)
        if (searchString?.count)! > 1 {
            let predicate = NSPredicate(format: "SELF contains[c] %@", searchString!)
            filterEmployeeList = employeeList.filter { predicate.evaluate(with: $0) }
           
            print("newSearch Count \(filterEmployeeList.count)")
            print("newSearch \(filterEmployeeList)")
         isSearch = true
          
           directoryListTableView.reloadData()
        }
        else {
           //
            isSearch = false
            directoryListTableView.reloadData()
        }
        return true
    }

}

extension DirectoryViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearch {
            return 1
        }
        else{
        return empSectionTitles.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch {
            return filterEmployeeList.count
        }
        else{
        let empKey = empSectionTitles[section]
           if let empValues = empDictionary[empKey] {
               return empValues.count
           }
               
           return 0
       
        }
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "empListCell", for: indexPath)
            cell.selectionStyle = .none
        let empNameLbl : UILabel = cell.viewWithTag(2) as! UILabel
        
        if isSearch {
           
                 
                    empNameLbl.text = filterEmployeeList[indexPath.row]
               
        }
        else{
        let empKey = empSectionTitles[indexPath.section]
            if let empValues = empDictionary[empKey] {
             
                empNameLbl.text = empValues[indexPath.row]
            }
        }

            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 70
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
        
       
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return empSectionTitles[section]
//    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if isSearch {
            return [""]
        }
        else{
        return empSectionTitles
        }
    }
}
