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
    @IBOutlet weak var segmentCoins: UISegmentedControl!
    @IBOutlet weak var containerSegment: UIView!
    
    var coins: [Coins.Coin] = []
    var currentList: [Coins.Coin] = []
    var loader: UIActivityIndicatorView?
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCoins.dataSource = self
        tableCoins.delegate = self
        
        tableCoins.register(
            UINib(nibName: "CoinTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CoinTableViewCell"
        )
        
        tableCoins.separatorStyle = .none
        setSegment()
        loader = CustomLoader(color: .red, view: view).loader
        containerSegment.layer.cornerRadius = 16
        containerSegment.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = .red
        refreshControl.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableCoins.addSubview(refreshControl)
        
        getCoinsAsync(refresh: false)
    }
    
    func setSegment() {
        segmentCoins.addTarget(self, action: #selector(segmentChange(segment:)), for: .valueChanged)
    }
    
    @objc func segmentChange(segment: UISegmentedControl){
        segmentCurrent(segment: segment)
    }
    
    func segmentCurrent(segment: UISegmentedControl) {
        switch(segment.selectedSegmentIndex){
        case 0:
            currentList = coins
            tableCoins.reloadData()
        case 1:
            currentList = coins.sorted { Double($0.changePercent24Hr) ?? 0 < Double($1.changePercent24Hr) ?? 0}
            tableCoins.reloadData()
        case 2:
            currentList = coins.sorted { Double($0.changePercent24Hr) ?? 0 > Double($1.changePercent24Hr) ?? 0}
            tableCoins.reloadData()
        default: return
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        getCoinsAsync(refresh: true)
    }
    
    func getCoinsAsync(refresh: Bool) {
        if(!refresh){
            loader?.startAnimating()
        }
        CustomDispatch.delayed(delay: 0.7){
            NetworkServices.assets { (coins, statusCode, error) in
                if let finalError = error {
                    print("error networking : \(finalError)")
                    
                } else {
                    if let coins = coins{
                        self.coins = coins.data
                        self.segmentCurrent(segment: self.segmentCoins)
                    }
                }
                self.loader?.stopAnimating()
                self.refreshControl.endRefreshing()
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
        return currentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier:"CoinTableViewCell",
            for: indexPath
        ) as? CoinTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(coin: currentList[indexPath.row], onClick: self)
        
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
        vc.coin = currentList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
