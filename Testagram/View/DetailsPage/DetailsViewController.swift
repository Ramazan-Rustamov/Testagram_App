//
//  DetailsViewController.swift
//  Testagram
//
//  Created by Ramazan Rustamov on 08.01.23.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    private let viewModel: FeedViewModel
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var imageSizeLabel: UILabel!

    @IBOutlet weak var imageTypeLabel: UILabel!
    
    @IBOutlet weak var imageTagsLabel: UILabel!
    
    @IBOutlet weak var infoListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillData()
        setupTableView()
        setupLabels()
        setupImageView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false

    }
    
    private func fillData() {
        guard let data = viewModel.selectedFeedData else {return}
        feedImageView.load(url: data.feedImageUrl ?? "")
        imageSizeLabel.text = "Size: \(data.imageSize ?? 0)"
        imageTypeLabel.text = "Type: \(data.imageType ?? "")"
        imageTagsLabel.text = "Tags: \(data.imageTag ?? "")"
    }
    
    private func setupTableView() {
        infoListTableView.delegate = self
        infoListTableView.dataSource = self
        
        infoListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "detailsCell")
    }
    
    private func setupLabels() {
        imageSizeLabel.adjustsFontSizeToFitWidth = true
        imageTypeLabel.adjustsFontSizeToFitWidth = true
        imageTagsLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupImageView() {
        feedImageView.contentMode = .scaleToFill
        feedImageView.layer.cornerRadius = 75
    }

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailsViewController", bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.detailsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath)
        
        cell.textLabel?.text = viewModel.detailsData[indexPath.item].title + ": \(viewModel.detailsData[indexPath.item].subtitle)"
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
