//
//  FeedViewController.swift
//  Testagram
//
//  Created by Ramazan Rustamov on 07.01.23.
//

import UIKit
import RxSwift

final class FeedViewController: UIViewController {
    
    private let viewModel = FeedViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        viewModel.fetchFeedData()
        viewModel.feedObserver
            .observe(on: MainScheduler())
            .subscribe { [unowned self] _ in
                self.feedTableView.reloadData()
            } onError: { _ in
                print ("Error")
            }
            .disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTableView() {
        feedTableView.dataSource = self
        feedTableView.delegate = self
        
        feedTableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "feedTableViewCell")
        
    }
    
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedTableViewCell", for: indexPath) as? FeedTableViewCell
        cell?.userNameLabel.text = viewModel.feedData[indexPath.item].userName
        cell?.userImageView.load(url: viewModel.feedData[indexPath.item].userImageUrl ?? "")
        cell?.feedImageView.load(url: viewModel.feedData[indexPath.item].feedImageUrl ?? "")
        
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedFeedData = viewModel.feedData[indexPath.item]
        navigationController?.pushViewController(DetailsViewController(viewModel: viewModel), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    
}
