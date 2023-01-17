//
//  ViewController.swift
//  MyEcommerce
//
//  Created by MAHFUJ on 12/1/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var tableView: UITableView!
    private var allProducts: [Product] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        //callAPI()
//        postList()
        fetchProducts()
    }

    func fetchProducts() {
        guard let url = URL(string: "https://fakestoreapi.com/products")
        else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                do {
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    for product in products {
                        self.allProducts.append(product)
                        print(String(format: "%.2f", product.price!))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
            else {
                print("ssss")
            }
        }
        task.resume()
    }
    
    
    func shopList() { //  networking
        guard let url = URL(string: "http://test.bdbizhub.com/Api/App/Orders")
        else {
            return
        }
        
        var bodyData: Data?
        
        // request with Dictionary
        
        var requestData: [String: Int] = [:]
        requestData["CompanyID"] = 29
        requestData["ShopFK"] = 20
        requestData["StatusID"] = 0
        requestData["UserID"] = 120

//        let requestData: [String: Int] = ["CompanyID" : 29, "ShopFK" : 20, "StatusID" : 0, "UserID" : 120]
         
//        bodyData = try? JSONSerialization.data(
//             withJSONObject: requestData,
//             options: []
//         )
        
        bodyData = try? JSONEncoder().encode(requestData)
        
        
        // request with Model ... start
//        let requestModel = ShopListRequest(CompanyID: 29, ShopFK: 20, StatusID: 0, UserID: 120)
//        let encoder = JSONEncoder()
//        bodyData = try? encoder.encode(requestModel) // request with Model ... end
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpBody = bodyData
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { responseData, response, error in
            if let responseData = responseData {
                do {
                    let decoder = JSONDecoder()
                    let shops = try decoder.decode([Shop].self, from: responseData)
                    
                    for shop in shops {
                        print(shop.code ?? "")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
        
        task.resume()
    }
    
    
    func jsonToString(json: AnyObject){
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) // first of all convert json to the data
           
            jsonDataToString(json: data)
            
        } catch let myJSONError {
            print(myJSONError)
        }
    }
    
    func jsonDataToString(json: Data){
        do {
            let convertedString = try? String(data: json, encoding: .utf8) // the data will be converted to the string
            print(convertedString!) // <-- here is ur string
            
        } catch  {
            print(error)
        }
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.reload(product: allProducts[indexPath.row])
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productVC = ProductViewController.initVC(product: allProducts[indexPath.row])
        self.navigationController?.pushViewController(productVC, animated: true)
    }

}
