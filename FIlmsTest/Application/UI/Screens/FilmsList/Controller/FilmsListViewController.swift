//
//  FilmsListViewController.swift
//  FIlmsTest
//
//  Created by Влад Лиховид on 17.06.2020.
//  Copyright © 2020 Влад Лиховид. All rights reserved.
//

import UIKit

final class FilmsListViewController: UIViewController {
    
    @IBOutlet weak var filmsListTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var onSelectMovie: ((_ id: Int) -> ())?
    
    let networkManager = NetworkManager.shared
    
    var filmsModels = [Film]() {
        didSet {
            filmsListTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        getFilmList()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func getFilmList() {
        networkManager.getFilmsList { [weak self] filmsList, error in
            DispatchQueue.main.async {
                if let filmsList = filmsList {
                    self?.filmsModels = filmsList.results
                } else if let error = error {
                    self?.showAlert(alertText: "Error", alertMessage: error.localizedDescription)
                }
            }
        }
    }
    
    private func searchByName(name: String) {
        networkManager.searchByName(name: name) { [weak self] filmsList, error in
            DispatchQueue.main.async {
                if let filmsList = filmsList {
                    self?.filmsModels = filmsList.results
                } else if let error = error {
                    self?.showAlert(alertText: "Error", alertMessage: error.localizedDescription)
                }
            }
        }
    }
}

extension FilmsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filmsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsListTableViewCell", for: indexPath) as! FilmsListTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! FilmsListTableViewCell
        
        let filmModel = filmsModels[indexPath.row]
        
        cell.titleLabel.text = filmModel.originalTitle
        cell.desriptionLabel.text = filmModel.overview
        cell.imageUrlPath = filmModel.posterPath
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        onSelectMovie?(filmsModels[indexPath.row].id)
    }
}

extension FilmsListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            searchByName(name: searchText)
        } else if searchText.isEmpty {
            getFilmList()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
            }
        }
    }
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}

extension FilmsListViewController: Storyboardable {
    static var storyboardName: String {
        "Main"
    }
}
