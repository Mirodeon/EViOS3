//
//  CryptoLiveViewController.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import UIKit
import SafariServices

class CryptoLiveViewController: UIViewController {
    @IBOutlet weak var tableCoins: UITableView!
    
    var coins: [Coins.Coin] = []
    var loader: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCoins.dataSource = self
        tableCoins.delegate = self
        
        tableCoins.register(
            UINib(nibName: "CoinTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CoinTableViewCell"
        )
        
        tableCoins.separatorStyle = .none
        
        loader = CustomLoader(color: .red, view: view).loader
        
        getCoinsAsync()
    }
    
    func getCoinsAsync() {
        loader?.startAnimating()
        CustomDispatch.delayed(delay: 0.7){
            NetworkServices.assets { (coins, statusCode, error) in
                if let finalError = error {
                    print("error networking : \(finalError)")
                    
                } else {
                    if let coins = coins{
                        self.coins.append(contentsOf: coins.data)
                        self.tableCoins.reloadData()
                    }
                }
                self.loader?.stopAnimating()
            }
        }
    }
}

extension CryptoLiveViewController: CoinCellClick {
    func exploreCoin(explorer: String) {
        guard let url = URL(string: explorer) else {
            return
        }
        let vc = SFSafariViewController (url: url)
        present(vc, animated: true)
    }
    
    
}

extension CryptoLiveViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier:"CoinTableViewCell",
            for: indexPath
        ) as? CoinTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(coin: coins[indexPath.row], onClick: self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "CryptoLive", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "History") as? HistoryViewController else{
            return
        }
        vc.coin = coins[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
