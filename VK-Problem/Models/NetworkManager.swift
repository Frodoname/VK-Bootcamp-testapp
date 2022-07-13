//
//  NetworkManager.swift
//  VK-Problem
//
//  Created by Fed on 13.07.2022.
//

import Foundation

protocol NetworkDelegate {
    func loadData(dataLoaded: [ServiceModel])
    func errorWarning(with: Error)
}


struct NetworkManager {
    
    var delegate: NetworkDelegate?
    
    let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
    
    func fetchData() {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let savedData = data {
                        do {
                            let result = try decoder.decode(ServiceData.self, from: savedData)
                            var array: [ServiceModel] = []
                            for i in result.body.services {
                                let name = i.name
                                let description = i.description
                                let link = i.link
                                let image = i.icon_url
                                
                                let serviceItem = ServiceModel(nameService: name, descriptionService: description, linkToService: link, linkTiImage: image)
                                
                                array.append(serviceItem)
                            }
                            self.delegate?.loadData(dataLoaded: array)
                        } catch {
                            self.delegate?.errorWarning(with: error)
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
        }
    }

}
