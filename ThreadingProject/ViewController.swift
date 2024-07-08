//
//  ViewController.swift
//  ThreadingProject
//
//  Created by Eray İnal on 8.07.2024.



//1 Threading Nedir? Birden fazla işi aynı anda yapabilme olayıdır.

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    //2: 
    let imageUrl=["https://upload.wikimedia.org/wikipedia/commons/c/cc/ESC_large_ISS022_ISS022-E-11387-edit_01.JPG" , "https://upload.wikimedia.org/wikipedia/commons/6/69/Very_Large_Telescope_Ready_for_Action_%28ESO%29.jpg"]
    
    
    var data = Data()
    var tracker = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate=self
        tableView.dataSource=self
        
        
        
        //4:
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.imageUrl[self.tracker])!)    //.4 background'da yapar
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)     //..4 main'de olmalı çünkü artık resim verisi elimde vu bu kullanıcı ile alakalı
            }
        }
        
        
        
        //.2:
        //data = try! Data(contentsOf: URL(string: imageUrl[tracker])!)
        //imageView.image = UIImage(data: data)
        
        
        //3:
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(changeImage))
    }
    
    
    //.3:
    @objc func changeImage(){
        if(tracker==0){
            tracker=1
        }else{
            tracker=0
        }
        
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.imageUrl[self.tracker])!)    //.4 background'da yapar
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)     //..4 main'de olmalı çünkü artık resim verisi elimde vu bu kullanıcı ile alakalı
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "Threading Test"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }


}

