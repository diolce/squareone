//
//  ViewController.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 29/10/21.
//

import UIKit
import RealmSwift
class ListCitiesViewController: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properties
    lazy var viewModel: ListCitiesModelView = {
        return ListCitiesModelView()
    }()
    
    var currentPage = 1
    let spinner = UIActivityIndicatorView(style:.large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Registrar celdas 
        tableView.register(CitiesTableViewCell.nib, forCellReuseIdentifier: CitiesTableViewCell.identifier)
        
       
        
        
        // Do any additional setup after loading the view.
        initVM()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initVM() {
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    //SHOW ALERT
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    //self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 0.0
                    })
                }else {
                    //self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.updateLoadingNextStatus = {
            DispatchQueue.main.async {
                if self.viewModel.isLoadingNext {
                    if self.tableView.tableFooterView == nil {
                        self.tableView.tableFooterView = self.spinner
                    }
                    (self.tableView.tableFooterView as! UIActivityIndicatorView).startAnimating()
                    self.tableView.tableFooterView!.isHidden = true
                } else {
                    if self.tableView.tableFooterView == nil {
                        self.tableView.tableFooterView = self.spinner
                    }
                    (self.tableView.tableFooterView as! UIActivityIndicatorView).stopAnimating()
                    self.tableView.tableFooterView!.isHidden = true
                }
            }
        }
        
        //Busco los items de la primera pagina
        viewModel.getCities(page: self.currentPage, filter: nil)
        
    }
}

extension ListCitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vmCell = self.viewModel.getCellViewModel(at: indexPath)
        if vmCell.lat != "0.0" && vmCell.log != "0.0"  {
            if let lat = NumberFormatter().number(from: vmCell.lat),let lng = NumberFormatter().number(from: vmCell.log) {
                let viewModel = MapCitiesModelView(lat: CGFloat(lat), lng: CGFloat(lng))
                let mapViewController = MapViewController()
                mapViewController.viewModel = viewModel
                self.navigationController?.pushViewController(mapViewController, animated: true)
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.viewModel.isSearch = false
            }
        }
    }
}

extension ListCitiesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: CitiesTableViewCell.identifier, for: indexPath) as! CitiesTableViewCell
        cell.viewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // fetch new data if user scroll to the last cell
        let lastElement = self.viewModel.numberOfRows - 1
        if indexPath.row == lastElement {
            fetchNextPage()
        }
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.row == self.viewModel.numberOfRows - 1
    }
    
    private func fetchNextPage() {
        self.currentPage += 1
        self.viewModel.getCities(page: self.currentPage, filter: nil)
    }
}

extension ListCitiesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.viewModel.isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.viewModel.isSearch = false
        self.currentPage = 1
        viewModel.getCities(page: self.currentPage, filter: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.isSearch = false
        self.currentPage = 1
        viewModel.getCities(page: self.currentPage, filter: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" || searchText.count == 0 {
            self.viewModel.isSearch = false
            self.currentPage = 1
            viewModel.getCities(page: self.currentPage, filter: nil)
        } else {
            self.viewModel.isSearch = true
            self.viewModel.getCities(page: nil, filter: searchText)
        }
    }
}
