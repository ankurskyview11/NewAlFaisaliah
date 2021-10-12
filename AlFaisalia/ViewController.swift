//
//  ViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 11/08/21.
//

import UIKit
import SkyFloatingLabelTextField
import AFNetworking
class ViewController: UIViewController {

   
    @IBOutlet weak var textF_Password: SkyFloatingLabelTextField!
    @IBOutlet weak var textF_email: SkyFloatingLabelTextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    var isShowPassword = false
    
    @IBOutlet weak var btnShowHidePassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailView.layer.borderColor = UIColor.lightGray.cgColor
        emailView.layer.borderWidth = 0.6
        passwordView.layer.borderColor = UIColor.lightGray.cgColor
        passwordView.layer.borderWidth = 0.6
       
        textF_email.text = "hrtest"
        textF_Password.text = "hRadm@1221"
        btnShowHidePassword.isSelected = true
        textF_Password.isSecureTextEntry = true
        
        
    }

    @IBAction func btnAction_LoginWithEmail(_ sender: Any) {
        print("LOGIN EMAIL")
        self.goToDashBoard()
//        if validateForm(userName: textF_email.text ?? "", password: textF_Password.text ?? "") {
//            loginMethod(email: textF_email.text ?? "", password: textF_Password.text ?? "")
//        }
    }
    
    @IBAction func btnAction_LoginWithLDAP(_ sender: Any) {
        print("LOGIN LDAP")
       
    }
    
    
    @IBAction func btnAction_SignUp(_ sender: Any) {
        print("SIGNUP")
    }
    
    @IBAction func btnAction_ForgotPassword(_ sender: Any) {
        print("FORGOT PASSWORD")
    }
    
    @IBAction func btnAction_showHidePassword(_ sender: Any) {
        if isShowPassword{
            textF_Password.isSecureTextEntry = true
            isShowPassword = false
            btnShowHidePassword.isSelected = true
            
        }
        else{
            
            
            textF_Password.isSecureTextEntry = false
            isShowPassword = true
            btnShowHidePassword.isSelected = false
        }
    }
    func validateForm(userName:String, password:String) -> Bool {
            var msg = ""
            if userName.isBlank{
                msg = "Please enter username/email."

                self.view.makeToast(msg)
                return false
            }
            else if password.isBlank{
                msg = "Please enter password."

                self.view.makeToast(msg)
                return false
            }
            else{
                return true
            }
        }
   /* func login_Method(email:String,password:String) {
        
        supportingfuction.showProgressHud("Please Wait...", labelText: "Processing Request!")
    
        
       
        let parameters = ["userID":email,
                          "pass":password]
       
      
     let url = "https://app.nupco.com/ldap/emp-login.php"
        print(url)
       
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as? Set<String>
        manager.post(url, parameters: parameters, headers: nil, progress: nil, success: {
            (operation, responseObject) in
            if let dict = responseObject as? NSDictionary {
                supportingfuction.hideProgressHudInView()
                print(dict)
              
        
                let str = dict["success"] as? Int
                if (str == 1) {
                    print("ok")
                   
                    
                self.goToDashBoard()
                    
                    
                 
                   
                }
                else
                {
                    
                    print("SOMETHING WENT WRONG ON LOGIN")
                    let msg = dict["msg"] as? String
                    self.view.makeToast(msg)
                    
                }
            }
        }, failure: {
            (operation, error) in
            supportingfuction.hideProgressHudInView()
            print("Error: " + error.localizedDescription)
           
        })
    }*/
    
    func loginMethod(email:String,password:String) {
        
        supportingfuction.showProgressHud("Please Wait...", labelText: "Processing Request!")
    
       
        let parameters = ["user":email,
                          "pass":password]
       
      
    
        let url = "https://source1.alfaisaliah.com/api/v1/ldap-login"
        print(url)
       
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as? Set<String>
        manager.post(url, parameters: parameters, headers: nil, progress: nil, success: {
            (operation, responseObject) in
            if let dict = responseObject as? NSDictionary {
                supportingfuction.hideProgressHudInView()
                print(dict)
              
        
                let str = dict["success"] as? Int
                if (str == 1) {
                    print("ok")
                    
                    if let dataDict = dict["data"] as? [String:Any] {
                        print("LOGIN DATA ===> \(dataDict)")
                        UserDefaults.standard.setValue(dataDict["EEmployeeId"], forKey: "EEmployeeId")
                        UserDefaults.standard.setValue(dataDict["EEmployeeName"], forKey: "EEmployeeName")
                        UserDefaults.standard.setValue(dataDict["EEmployeeNo"], forKey: "EEmployeeNo")
                        self.goToDashBoard()
                        
                    }
                    let msg = dict["msg"] as? String
                    self.view.makeToast(msg)
                    
               
                    
                    
                 
                   
                }
                else
                {
                    
                    print("SOMETHING WENT WRONG ON LOGIN")
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
    func goToDashBoard() {
                let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
                tabBarVC.modalPresentationStyle = .fullScreen
                self.present(tabBarVC, animated: true, completion: nil)
    }
}

