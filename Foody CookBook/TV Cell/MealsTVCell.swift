//
//  MealsTVCell.swift
//  Foody CookBook
//
//  Created by Chandresh Kachariya on 27/02/21.
//

import UIKit
import IHProgressHUD

class MealsTVCell: UITableViewCell {

    var dictRandomMeal = NSDictionary()

    /*******************UIImageView**************************/
    @IBOutlet weak var imgMealThumb: UIImageView!
    
    /*******************UILabel**************************/
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblTags: UILabel!
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var lblInstructions: UILabel!

    @IBOutlet weak var btnBook: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initSetup()
    }
    
    func initSetup() {
    
        imgMealThumb.layer.roundBorder(cornerRadius: 8, color: greyColor_0_5, borderWith: 0.5)
        
        lblName.textColor = blackColor
        lblName.font = getFont(fontName: _font_Montserrat_Regular, fontSize: 17)
        
        lblCategory.textColor = greyColor
        lblCategory.font = getFont(fontName: _font_Montserrat_Regular, fontSize: 15)
        
        lblTags.textColor = greyColor
        lblTags.font = getFont(fontName: _font_Montserrat_Regular, fontSize: 15)
        
        lblArea.textColor = greyColor
        lblArea.font = getFont(fontName: _font_Montserrat_Regular, fontSize: 15)
        
        lblInstructions.textColor = greyColor
        lblInstructions.font = getFont(fontName: _font_Montserrat_Regular, fontSize: 15)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnBook(_ sender: UIButton) {
        
        sender.isSelected = true
        
        theAppDelegate?.arrFavouriteMeals.add(dictRandomMeal)
        
        IHProgressHUD.showSuccesswithStatus("Added as Favourite")
        
        delay(bySeconds: 1.0) {
            IHProgressHUD.dismiss()
        }
    }
    
    
}
