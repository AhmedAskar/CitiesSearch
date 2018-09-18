//
//  CitiesSearchViewController.swift
//  SearchCities
//
//  Created by Ahmed Askar on 9/15/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import UIKit

class CitiesSearchViewController: UITableViewController {
    
    // MARK: Properities
    let searchController = UISearchController(searchResultsController: nil)
    var selectedCity: City?
    
    lazy var viewModel: CitiesViewModel = {
        return CitiesViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = Constant.cities
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constant.searchPlaceHolder
        self.tableView.tableHeaderView = searchController.searchBar

        definesPresentationContext = true
        
        initVM()
    }
    
    func initVM() {

        // Native binding
        viewModel.errorCitiesFailuer = { [weak self] () in
            DispatchQueue.main.async {
                if let errorMessage = self?.viewModel.errorMessage {
                    self?.showAlert(errorMessage)
                }
            }
        }
        
        viewModel.citiesLoadCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.findCities(result: .all)
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: Constant.alertTitle , message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: Constant.alertBtn, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CitiesSearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier)
        let city = viewModel.cities[indexPath.row]
        cell?.textLabel?.text = "\(city.name),\(city.country)"
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedCity = viewModel.cities[indexPath.row]
        return indexPath
    }
}

extension CitiesSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            if !text.isEmpty {
                viewModel.findCities(result: .search(text: text))
            }else{
                viewModel.findCities(result: .all)
            }
        }
    }
}

extension CitiesSearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CityMapViewController {
            vc.city = selectedCity
        }
    }
}

