//
//  ViewController.swift
//  companyMachineTask
//
//  Created by Digvijay Nikam on 17/12/22.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {

    @IBOutlet weak var FVCCollectionView: UICollectionView!
    
    @IBOutlet weak var FVCTableView: UITableView!
    
    var api = [userApiResponce]()
    var apiproduct = [productApiResponce]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        dataAndDelegate()
        dataFatchFromApi()
        fatchingDataFromApiproduct()
        
    }
    func registerNib(){
        let uinib = UINib(nibName: "userTableViewCell", bundle: nil)
        self.FVCTableView.register(uinib, forCellReuseIdentifier: "userTableViewCell")
        let uinib1 = UINib(nibName: "productCollectionViewCell", bundle: nil)
        self.FVCCollectionView.register(uinib1, forCellWithReuseIdentifier: "productCollectionViewCell")
    }
    
    func dataAndDelegate(){
        FVCTableView.dataSource = self
        FVCTableView.delegate = self
        FVCCollectionView.dataSource = self
        FVCCollectionView.delegate = self
    }
    
    func dataFatchFromApi(){
        
        let urlString = "https://fakestoreapi.com/users"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        var session = URLSession(configuration: .default)
        
        var dataTask = session.dataTask(with: request) {data, responce, error in
            print(data)
            print(error)
            
            let jsonObject = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            for dictionary in jsonObject{
                let eachdictionary = dictionary as! [String:Any]
                let name = eachdictionary["name"] as! [String:Any]
                let ufirstName = name["firstname"] as! String
                let ulastName = name["lastname"] as! String
                
                let newObj = userApiResponce(name: Name(firstName: ufirstName, lastName: ulastName))
                self.api.append(newObj)
            }
                
                DispatchQueue.main.async {
                    self.FVCTableView.reloadData()
                }
        }.resume()
        }
func fatchingDataFromApiproduct(){
        let urlString = "https://fakestoreapi.com/products"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        var dataTask = session.dataTask(with: request) {data, responce, error in
            print(data)
            print(error)
            
            let getJSONObject = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            for dictionary in getJSONObject{
                let eachdictionary = dictionary as! [String:Any]
                let productImage = eachdictionary["image"] as! String
                
                let newObj = productApiResponce(image: productImage)
                self.apiproduct.append(newObj)
                
                DispatchQueue.main.async {
                    self.FVCCollectionView.reloadData()
                }
            }
        }.resume()
}
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return api.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userTableViewCell = self.FVCTableView.dequeueReusableCell(withIdentifier: "userTableViewCell", for: indexPath) as! userTableViewCell
        userTableViewCell.fristNameLabel.text = api[indexPath.row].name.firstName
        userTableViewCell.lastNameLabel.text = api[indexPath.row].name.lastName
        return userTableViewCell
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiproduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCollectionViewCell = self.FVCCollectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! productCollectionViewCell
        let imageurl = NSURL(string: apiproduct[indexPath.row].image)
        productCollectionViewCell.productImageView.sd_setImage(with: imageurl as URL?)
        
        return productCollectionViewCell
    }
}
extension ViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 380, height: 172)
    }
}
