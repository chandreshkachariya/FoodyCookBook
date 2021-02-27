//
//  RandomVC.swift
//  Foody CookBook
//
//  Created by Chandresh Kachariya on 27/02/21.
//

import UIKit
import IHProgressHUD

protocol productDetailsDelegate {
    func productDetails(dictProduct: NSDictionary)
}

class RandomVC: UIViewController, productDetailsDelegate {

    var dictRandomMeal = NSDictionary()
    
    /*******************UIImageView**************************/
    @IBOutlet weak var imgMealThumb: UIImageView!
    
    /*******************UILabel**************************/
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblTags: UILabel!
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var lblInstructions: UILabel!

    /*******************UIButton**************************/
    @IBOutlet weak var btnYoutube: UIButton!
    @IBOutlet weak var btnSource: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSetup()
        
        callApiForGetRandomMeals()
    }
    
    func initSetup() {
    
        imgMealThumb.layer.roundBorder(cornerRadius: 8, color: greyColor_0_5, borderWith: 0.5)

        btnYoutube.setTitleColor(redColor, for: UIControl.State.normal)
        btnYoutube.titleLabel?.font = getFont(fontName: _font_Montserrat_Bold, fontSize: 17)
        
        btnSource.setTitleColor(blueColor, for: UIControl.State.normal)
        btnSource.titleLabel?.font = getFont(fontName: _font_Montserrat_Bold, fontSize: 17)
        
        lblName.textColor = blackColor
        lblName.font = getFont(fontName: _font_Montserrat_Regular, fontSize: 17)
        
        lblCategory.textColor = greyColor
        lblCategory.font = getFont(fontName: _font_Montserrat_Regular, fontSize: 15)
        
        lblTags.textColor = greyColor
        lblTags.font = getFont(fontName: _font_Montserrat_Regular, fontSize: 15)
        
        lblArea.textColor = greyColor
        lblArea.font = getFont(fontName: _font_Montserrat_Regular, fontSize: 15)
    }
    
    func updateDetails() {
        lblName.text = dictRandomMeal.value(forKey: _key_strMeal) as? String ?? ""
        
        lblCategory.text = dictRandomMeal.value(forKey: _key_strCategory) as? String ?? ""

        lblTags.text = dictRandomMeal.value(forKey: _key_strTags) as? String ?? ""

        lblArea.text = dictRandomMeal.value(forKey: _key_strArea) as? String ?? ""

        lblInstructions.text = dictRandomMeal.value(forKey: _key_strInstructions) as? String ?? ""
        
        self.imgMealThumb.getImage(url: (dictRandomMeal.value(forKey: _key_strMealThumb) as? String ?? ""), placeholderImage: UIImage.init(named: "image")) { (success) in
            
            self.imgMealThumb.contentMode = .scaleAspectFill
            
        } failer: { (faild) in
            self.imgMealThumb.contentMode = .center
        }

    }
    
    //MARK: - product Details Delegate
    func productDetails(dictProduct: NSDictionary) {
        self.dictRandomMeal = dictProduct
        updateDetails()
        
        IHProgressHUD.showSuccesswithStatus(dictRandomMeal.value(forKey: _key_strMeal) as? String ?? "")
        delay(bySeconds: 1.0) {
            IHProgressHUD.dismiss()
        }
    }
    
    //MARK: - IBAction
    @IBAction func btnSearch(_ sender: Any) {
        let vc = UIStoryboard.init(name: _storyboard_name, bundle: Bundle.main).instantiateViewController(withIdentifier: _vc_SearchVC) as? SearchVC
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnBookmark(_ sender: Any) {
        let vc = UIStoryboard.init(name: _storyboard_name, bundle: Bundle.main).instantiateViewController(withIdentifier: _vc_FavouriteVC) as? FavouriteVC
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnYoutube(_ sender: Any) {
        openLinkInSafari(url: (URL.init(string: (dictRandomMeal.value(forKey: _key_strYoutube) as! String)) ?? _url_google)!)
    }
    
    @IBAction func btnSource(_ sender: Any) {
        openLinkInSafari(url: (URL.init(string: (dictRandomMeal.value(forKey: _key_strSource) as! String)) ?? _url_google)!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK:- WebServices

    func callApiForGetRandomMeals() {
            
        HttpClientApi.instance().callAPI(url: _api_random, params: nil, showLoading: true,  methods: .GET, success: { (data) in
            //po (data as! [String : Any])["user_data"]

            let arrMeals = (data as! [String : Any])["meals"] as! NSArray
            if (arrMeals.count != 0) {
                
                self.dictRandomMeal = arrMeals.object(at: 0) as! NSDictionary
                self.updateDetails()
            }else {
                Helper.showAlert(title: (data as! [String : Any])["message"] as? String, message: nil)
            }

        }) { (fail) in
            Helper.showAlert(title: fail as? String, message: nil)
        }
    
    }

}
