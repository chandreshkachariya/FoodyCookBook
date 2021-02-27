//
//  Constants.swift
//  Video Tutor
//
//  Created by Chandresh Kachariya on 14/08/19.
//  Copyright © 2019 Chandresh Kachariya. All rights reserved.
//

import Foundation
import UIKit

// MARK: - API List
let BASE_URL                            = "https://www.themealdb.com/api/json/v1/1/"

let _api_random                         = "random.php"
let _api_search                         = "search.php"

let _api_tag_search                     = "s"

let _key_strMeal                    = "strMeal"
let _key_strCategory                = "strCategory"
let _key_strArea                    = "strArea"
let _key_strInstructions            = "strInstructions"
let _key_strMealThumb               = "strMealThumb"
let _key_strTags                    = "strTags"
let _key_strYoutube                 = "strYoutube"
let _key_strSource                  = "strSource"


let _url_google = URL.init(string: "https://google.com")

// MARK: - Storyboard name
let _storyboard_name = "Main"

let _vc_RandomVC = "RandomVC"
let _vc_SearchVC = "SearchVC"
let _vc_FavouriteVC = "FavouriteVC"

// MARK: - Font Name
let _font_Montserrat_Black = "Montserrat-Black"
let _font_Montserrat_BlackItalic = "Montserrat-BlackItalic"
let _font_Montserrat_Bold = "Montserrat-Bold"
let _font_Montserrat_BoldItalic = "Montserrat-BoldItalic"
let _font_Montserrat_ExtraBold = "Montserrat-ExtraBold"
let _font_Montserrat_ExtraBoldItalic = "Montserrat-ExtraBoldItalic"
let _font_Montserrat_ExtraLight = "Montserrat-ExtraLight"
let _font_Montserrat_ExtraLightItalic = "Montserrat-ExtraLightItalic"
let _font_Montserrat_Italic = "Montserrat-Italic"
let _font_Montserrat_Light = "Montserrat-Light"
let _font_Montserrat_LightItalic = "Montserrat-LightItalic"
let _font_Montserrat_Medium = "Montserrat-Medium"
let _font_Montserrat_MediumItalic = "Montserrat-MediumItalic"
let _font_Montserrat_Regular = "Montserrat-Regular"
let _font_Montserrat_SemiBold = "Montserrat-SemiBold"
let _font_Montserrat_SemiBoldItalic = "Montserrat-SemiBoldItalic"
let _font_Montserrat_Thin = "Montserrat-Thin"
let _font_Montserrat_ThinItalic = "Montserrat-ThinItalic"

// MARK: - Message
let _error_select_age = "Please select Age."
let _invalid_gender = "Please select Gender."
let _select_one_language = "Select at least one language."
let _password_not_match = "New password and confirm password do not match.."
let _empty_phone = "Phone number is required."
let _empty_message = "Message is required."

let _empty_full_name = "Full name is required."
let _empty_date = "Date is required."
let _empty_month = "Month is required."
let _empty_year = "Year is required."
let _invalid_date = "Please select valid Date."
let _empty_email = "Email is required."
let _error_invalid_email = "Email is not valid."
let _empty_password = "Password is required."
let _empty_verify_password = "Verify password is required."
let _error_not_match_confirm_password = "Password & Verify password is not match."
let _error_select_sport = "Please select sport."
let _empty_looking_for = "I'm Looking for is required."
let _empty_organization_name = "Organization name is required."
let _empty_address_name = "Address is required."
let _empty_city_name = "City is required."
let _empty_state_name = "State is required."
let _empty_zip_code_name = "Zip code is required."
let _empty_ein_name = "EIN code is required."
let _empty_country_name = "Country is required."
let _empty_current_password = "Current Password is required."
let _empty_new_password = "New Password is required."
let _error_not_match_confirm_passwd = "Password & Confiem password is not match."
let _empty_aboutme = "About me is required."
let _error_select_position_name = "Please select Position name."
let _error_select_club_name = "Please select Club name."
let _error_select_school_name = "Please select School name."
let _error_account_number_is_required = "Account number is required."
let _error_bank_name_is_required = "Bank name is required."
let _error_account_holder_name_is_required = "Account holder name is required."
let _error_IFSC_code_is_required = "Bank IFSC code is required."


// MARK: - API Message
var NO_INTERNET_CONNECTION = "Please check your Internet connection."
var SOMTHING_WRONG = "Something went wrong, Please try again!"
var FAILED = "Failed"



// MARK: - USERDEFAULT KEY
var _key_UserDetails : String       = "UserDetails"
var _key_AlreadyLogin : String      = "AlreadyLogin"
var _key_token_auth : String        = "tokenAuth"
var _key_selected_language : String = "selectedLanguage"


// MARK: - Constant Text
var _text_gender_male = "Male"
var _text_gender_female = "Female"
var _text_gender_other = "Other"

var _text_email_notifications = "Email Notifications"
var _text_push_notifications  = "Push Notifications"
var _text_position = "POSITION"
var _text_club = "CLUB"
var _text_schools = "SCHOOLS"
var _text_selecct_position = "Select Position"
var _text_selecct_club = "Select Club"
var _text_selecct_schools = "Select School"

// MARK: - API_KEY
var id = "id"


struct ScreenSize{
    ///Width: *Screen width*
    static let Width = UIScreen.main.bounds.width
    ///Height: *Screen Height*
    static let Height = UIScreen.main.bounds.height

}
