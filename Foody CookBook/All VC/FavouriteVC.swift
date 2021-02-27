//
//  FavouriteVC.swift
//  Foody CookBook
//
//  Created by Chandresh Kachariya on 27/02/21.
//

import UIKit

class FavouriteVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var delegate: productDetailsDelegate?

    /*******************UITableView**************************/
    @IBOutlet weak var tblSearchList: UITableView!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSetup()
    }
    
    func initSetup() {
        self.title = "Favourite"
        
        tblSearchList.estimatedRowHeight = 44
        tblSearchList.dataSource = self
        tblSearchList.delegate = self
        tblSearchList.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)

        tblSearchList.tableFooterView = UIView.init()
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tblSearchList.addSubview(refreshControl)
    }
    
    // MARK: - UITableView
    let reuseIdentifier = "MealsTVCell"

    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
        refreshControl.endRefreshing()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theAppDelegate?.arrFavouriteMeals.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MealsTVCell
        
        let dictRandomMeal = theAppDelegate?.arrFavouriteMeals.object(at: indexPath.row) as! NSDictionary
        
        cell.dictRandomMeal = dictRandomMeal
        
        cell.updateDetails()
        
        cell.btnBook.isHidden = true

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        if delegate != nil {
            let dictRandomMeal = theAppDelegate?.arrFavouriteMeals.object(at: indexPath.row) as! NSDictionary
            delegate?.productDetails(dictProduct: dictRandomMeal)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
