//
//  HistoryViewController.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var tableHistory: UITableView!
    
    var coin: Coins.Coin?
    var history: [History.Record] = []
    var loader: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableHistory.dataSource = self
        tableHistory.delegate = self
        
        tableHistory.register(
            UINib(nibName: "RecordTableViewCell", bundle: nil),
            forCellReuseIdentifier: "RecordTableViewCell"
        )
        tableHistory.register(
            UINib(nibName: "LeadHistoryTableViewCell", bundle: nil),
            forCellReuseIdentifier: "LeadHistoryTableViewCell"
        )
        
        tableHistory.separatorStyle = .none
        loader = CustomLoader(color: .red, view: view).loader
        getHistoryAsync()
    }
    
    func getHistoryAsync() {
        loader?.startAnimating()
        CustomDispatch.delayed(delay: 0.7){
            if let id = self.coin?.id {
                NetworkServices.history(id: id) { (history, statusCode, error) in
                    if let finalError = error {
                        print("error networking : \(finalError)")
                        
                    } else {
                        if let history = history{
                            self.history.append(contentsOf: history.data.reversed())
                            self.tableHistory.reloadData()
                        }
                    }
                    self.loader?.stopAnimating()
                }
            }
        }
    }
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if(indexPath.row == 0) {
            guard let customCell = tableView.dequeueReusableCell(
                withIdentifier:"LeadHistoryTableViewCell",
                for: indexPath
            ) as? LeadHistoryTableViewCell else {
                return UITableViewCell()
            }
            
            if let coin = coin {
                customCell.setup(record: history[indexPath.row], coin: coin)
            }
            
            cell = customCell
        } else {
            guard let customCell = tableView.dequeueReusableCell(
                withIdentifier:"RecordTableViewCell",
                for: indexPath
            ) as? RecordTableViewCell else {
                return UITableViewCell()
            }
            
            customCell.setup(record: history[indexPath.row])
            
            cell = customCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 212 : view.frame.size.height/8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
