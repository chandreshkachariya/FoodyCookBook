//
//  SearchVC.swift
//  Foody CookBook
//
//  Created by Chandresh Kachariya on 27/02/21.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var arrMeals = NSArray()
    var delegate: productDetailsDelegate?
    
    /*******************UISearchBar**************************/
    @IBOutlet weak var searchBar: UISearchBar!
    
    /*******************UITableView**************************/
    @IBOutlet weak var tblSearchList: UITableView!
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSetup()
        
        callApiForGetSearchList()
    }
    
    func initSetup() {
        self.title = "Search"
        
        searchBar.delegate = self
    
        tblSearchList.estimatedRowHeight = 44
        tblSearchList.dataSource = self
        tblSearchList.delegate = self
        tblSearchList.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)

        tblSearchList.tableFooterView = UIView.init()
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tblSearchList.addSubview(refreshControl)
    }
    
    // MARK: - UISearchBar Delegate Methods

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        delay(bySeconds: 0.3) {
            self.refresh(sender: self)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.callApiForGetSearchList()
    }
    
    // MARK: - UITableView
    let reuseIdentifier = "MealsTVCell"

    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
        refreshControl.endRefreshing()
        
        self.callApiForGetSearchList()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMeals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MealsTVCell
        
        let dictRandomMeal = self.arrMeals.object(at: indexPath.row) as! NSDictionary
        
        cell.dictRandomMeal = dictRandomMeal
        
        cell.updateDetails()
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        if delegate != nil {
            let dictRandomMeal = self.arrMeals.object(at: indexPath.row) as! NSDictionary
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

// MARK: - WebServices
extension SearchVC {
    
    func callApiForGetSearchList() {
                
        var showLoading = true
        if !(self.searchBar.text ?? "").elementsEqual("") {
            showLoading = false
        }
        
        let params = [
            _api_tag_search : self.searchBar.text ?? ""
        ] as [String : Any]
        
        print(params)
        
        HttpClientApi.instance().callAPI(url: _api_search, params: params, showLoading: showLoading,  methods: .GET, success: { (data) in
            //po (data as! [String : Any])["user_data"]
            
            self.arrMeals = (data as! [String : Any])["meals"] as? NSArray ?? NSArray()
            self.tblSearchList.reloadData()
                        
        }) { (fail) in
            Helper.showAlert(title: fail as? String, message: nil)
        }
    
    }
    
}
