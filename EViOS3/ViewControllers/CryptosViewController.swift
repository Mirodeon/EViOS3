//
//  CryptosViewController.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import UIKit

class CryptosViewController: UIViewController {
    @IBOutlet weak var tableIllustrate: UITableView!
    
    var illustrate: [IllustrateCoins.IllustrateCoin] = []
    var loader: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableIllustrate.dataSource = self
        tableIllustrate.delegate = self
        
        tableIllustrate.register(
            UINib(nibName: "IllustrateTableViewCell", bundle: nil),
            forCellReuseIdentifier: "IllustrateTableViewCell"
        )
        
        tableIllustrate.separatorStyle = .none
        
        loader = CustomLoader(color: .red, view: view).loader
        
        getIlluAsync()
    }
    
    func getIlluAsync() {
        loader?.startAnimating()
        CustomDispatch.delayed(delay: 0.7){
            NetworkServices.illustrate { (illustrate, statusCode, error) in
                if let finalError = error {
                    print("error networking : \(finalError)")
                    
                } else {
                    if let illustrate = illustrate{
                        self.illustrate.append(contentsOf: illustrate.data)
                        self.tableIllustrate.reloadData()
                    }
                }
                self.loader?.stopAnimating()
            }
        }
    }
}

extension CryptosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return illustrate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier:"IllustrateTableViewCell",
            for: indexPath
        ) as? IllustrateTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(illu: illustrate[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
