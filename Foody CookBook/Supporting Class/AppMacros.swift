//
//  AppMacros.swift
//  ProHunterSwift
//
//  Created by TechnoMac-11 on 21/03/18.
//  Copyright © 2018 TechnoMac-11. All rights reserved.
//

import Foundation
import UIKit
import IHProgressHUD

// Mark : - Define custome color
let objAppDelegate = UIApplication.shared.delegate as! AppDelegate


// MARK: -  Define AppDelegate Instance

let clearColor = UIColor.clear
let whiteColor = UIColor.white
let blackColor = UIColor.black
let blueColor = UIColor.blue

let blackColor_0_7 = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.7)
let blackColor_0_4 = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.4)
let yellowColor = UIColor(red: 280.0/255.0, green: 180.0/255.0, blue: 0.0/255.0, alpha: 1.0)
let redColor = UIColor(red: 233.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1.0)
let redColor_light = UIColor(red: 73.0/255.0, green: 15.0/255.0, blue: 15.0/255.0, alpha: 1.0)
let greyColor = UIColor(red: 112.0/255.0, green: 112.0/255.0, blue: 112.0/255.0, alpha: 1.0)
let greyColor_0_5 = UIColor(red: 112.0/255.0, green: 112.0/255.0, blue: 112.0/255.0, alpha: 0.5)
let greyColor_0_1 = UIColor(red: 112.0/255.0, green: 112.0/255.0, blue: 112.0/255.0, alpha: 0.1)
let blueColor_dark = UIColor(red: 40.0/255.0, green: 24.0/255.0, blue: 38.0/255.0, alpha: 1.0)
let greenColor_dark = UIColor(red: 1.0/255.0, green: 163.0/255.0, blue: 104.0/255.0, alpha: 1.0)

func setNavigationTitle(label: UILabel) {
    label.textColor = whiteColor
    label.font = getFont(fontName: _font_Montserrat_SemiBold, fontSize: 17)
}

func setNavigationBarShadow(navigationBar: UIView) {
    navigationBar.dropShadow(color: blackColor, opacity: 0.4, offSet: CGSize(width: -1, height: 1), radius: 2, scale: false)
}

func setLabelNotFound(parentView: UIView, message: String) {
    let label = UILabel(frame: CGRect(x: 8, y: 8, width: parentView.frame.width - 16, height: parentView.frame.height - 16))
    
    label.textColor = whiteColor
    label.font = getFont(fontName: _font_Montserrat_Regular, fontSize: 17)
    label.text = message
    label.numberOfLines = 0
    label.textAlignment = .center
    
    parentView.addSubview(label)
}

func removeAllSubView(parentView: UIView) {
    for view in parentView.subviews{
        view.removeFromSuperview()
    }
}


// MARK: -  HUD
func showProgress() {
    DispatchQueue.global(qos: .utility).async {
        IHProgressHUD.set(defaultMaskType: .black)
        IHProgressHUD.show()
    }
}

func closeProgress() {
    IHProgressHUD.dismiss()
}


// MARK: - Save Data UserDefaults
func setDictionary(dictionary: NSDictionary, _key: String) {
    let data = NSKeyedArchiver.archivedData(withRootObject: dictionary)
    let userDefaults = UserDefaults.standard
    userDefaults.set(data, forKey:_key)
    UserDefaults.standard.synchronize()
}

public func getDictionary(_key: String) -> NSDictionary {
    let data = UserDefaults.standard.object(forKey: _key) as? NSData
    if data != nil {
        let object = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as! NSDictionary
        return object;
    }else {
        return NSDictionary()
    }
}

func setArray(array: NSArray, _key: String) {
    let data = NSKeyedArchiver.archivedData(withRootObject: array)
    let userDefaults = UserDefaults.standard
    userDefaults.set(data, forKey:_key)
    UserDefaults.standard.synchronize()
}

public func getArray(_key: String) -> NSArray {
    let data = UserDefaults.standard.object(forKey: _key) as! NSData
    let object = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! NSArray
    return object;
}

// MARK : - User Details
public func getUserDetails() -> NSDictionary {
    
    return getDictionary(_key: _key_UserDetails)
}

public func setUserLoggedIn() {
    UserDefaults.standard.set(true, forKey: _key_AlreadyLogin)
    UserDefaults.standard.synchronize()
}

public func setUserLoggedOut() {
    UserDefaults.standard.set(false, forKey: _key_AlreadyLogin)
    UserDefaults.standard.synchronize()
}

public func getUserLoggedIn() -> Bool {
    return UserDefaults.standard.bool(forKey: _key_AlreadyLogin)
}

public func setBoolUD(value: Bool, forkey: String) {
    UserDefaults.standard.set(value, forKey: forkey)
    UserDefaults.standard.synchronize()
}

public func getBoolUD(forkey: String) -> Bool {
    return UserDefaults.standard.bool(forKey: forkey)
}

public func setValueUD(value: String, forkey: String) {
    UserDefaults.standard.set(value, forKey: forkey)
    UserDefaults.standard.synchronize()
}

public func getValueUD(forkey: String) -> String {
    return UserDefaults.standard.value(forKey: forkey) as? String ?? ""
}

