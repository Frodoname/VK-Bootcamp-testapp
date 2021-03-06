//
//  TableViewController.swift
//  VK-Problem
//
//  Created by Fed on 13.07.2022.
//

import UIKit
import SafariServices

class TableViewController: UITableViewController {
    
    var networkManager = NetworkManager()
    var arrayOfServices: [ServiceModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "reusableCell")
        self.tableView.separatorColor = .gray
        
        networkManager.delegate = self
        networkManager.fetchData()
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  arrayOfServices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! TableViewCell
        let serviceRow = arrayOfServices[indexPath.row]
        cell.nameServiceLabel.text = serviceRow.nameService
        cell.descriptionServiceLabel.text = serviceRow.descriptionService
        cell.serviceImage.loadFrom(URLAddress: serviceRow.linkTiImage)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = URL(string: arrayOfServices[indexPath.row].linkToService) {
            
            if let urlHost = url.host {
                let resultFormat = formatForScheme(with: urlHost)
                
                guard let urlForScheme = URL(string: "\(resultFormat)://") else {return}
                if UIApplication.shared.canOpenURL(urlForScheme) {
                    UIApplication.shared.open(urlForScheme, options: [:], completionHandler: nil)
                } else {
                    if let url = URL(string: arrayOfServices[indexPath.row].linkToService) {
                        let vc = SFSafariViewController(url: url)
                        present(vc, animated: true)
                    }
                    
                }
            }
        }
        
    }
    
}

//MARK: - Network Extension

extension TableViewController: NetworkDelegate {
    
    func loadData(dataLoaded: [ServiceModel]) {
        DispatchQueue.main.async {
            self.arrayOfServices = dataLoaded
            self.tableView.reloadData()
        }
        
    }
    
    func errorWarning(with: Error) {
        print(with.localizedDescription)
    }
    
}

//MARK: - Format Web-adress for scheme

extension TableViewController {
    
    func formatForScheme(with url: String) -> String {
        var removeLastPoint = url.components(separatedBy: ".")
        removeLastPoint.removeLast()
        
        return removeLastPoint.joined(separator: ".")
        
    }
}


