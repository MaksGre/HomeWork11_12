//
//  ResultsTableViewController.swift
//  Home Work 11. Alamofire
//
//  Created by Maksim Grebenozhko on 28/08/2019.
//  Copyright © 2019 Maksim Grebenozhko. All rights reserved.
//

import UIKit
import Alamofire

class ResultsTableViewController: UITableViewController {

    var results: ResultBySearch!
    var imdbID: String!
    private let detailsSegue = "segueDetails"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 130
    }

    @IBAction func unwindToResultsVC(_ sender: UIStoryboardSegue) {}
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = results?.search?.count else { return 0 }
        
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        if let result = results?.search?[indexPath.row] {
            cell.configureCellBy(result)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        imdbID = results?.search?[indexPath.row].imdbID
        performSegue(withIdentifier: detailsSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsSegue as String? {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.fetchDetailsFor(imdbID)
        }
    }
    
    //MARK: - Networking
    
    func fetchResultsFor(_ search: String) {
        
        let search = search.replacingOccurrences(of: " ", with: "%20")

        let urlString = "https://movie-database-imdb-alternative.p.rapidapi.com/?page=1&r=json&s=\(search)"
        guard let url = URL(string: urlString) else { return }
        
        let headers = [
            "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com",
            "x-rapidapi-key": "6976e2adedmsha25ff2200c4f160p14bd1djsn66995eb60a7b"
        ]
    
        request(url,
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                headers: headers).validate().responseJSON { dataResponse in
                    
                    switch dataResponse.result {
                    case .success:
                        let decoder = JSONDecoder()
                        do {
                            if let data = dataResponse.data {
                                self.results = try decoder.decode(ResultBySearch.self, from: data)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        } catch let error {
                            self.showErrorMessage(error.localizedDescription)
                        }
                    case .failure(let error):
                        print(error)
                    }
            }
    }
    
    private func showErrorMessage(_ message: String) {
        let alert = UIAlertController(
            title: "Error!",
            message: message,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
