//
//  FeedViewModel.swift
//  Testagram
//
//  Created by Ramazan Rustamov on 07.01.23.
//

import Foundation
import RxSwift

class FeedViewModel {
    
    private let disposeBag = DisposeBag()
    
    var feedData: [FeedDataModel] = []
    
    var selectedFeedData: FeedDataModel?
    
    lazy var detailsData: [InfoListDataModel] = [
        .init(title: "User", subtitle: selectedFeedData?.userName ?? ""),
        .init(title: "Views", subtitle: "\(selectedFeedData?.views ?? 0)"),
        .init(title: "Likes", subtitle: "\(selectedFeedData?.likes ?? 0)"),
        .init(title: "Comments", subtitle: "\(selectedFeedData?.comments ?? 0)"),
        .init(title: "Downloads", subtitle: "\(selectedFeedData?.downloads ?? 0)")
    ]
    
    let feedObserver: PublishSubject<[FeedDataModel]> = PublishSubject<[FeedDataModel]>()
    
    func fetchFeedData() {
        RepositoryController.fetchData(urlString: "https://pixabay.com/api/?key=32681679-b132ec043f43ec04eeb104236&q=yellow+flowers&image_type=photo&pretty=true)")
            .subscribe { [unowned self] data in
                let allData = data as? [String: Any]
                let hits = (allData?["hits"] as? [[String: Any]]) ?? [[String: Any]]()
                let feedData = hits.map({ FeedDataModel(data: $0) })
                self.feedData = feedData
                self.feedObserver.onNext(feedData)
            } onError: { [unowned self] error in
                self.feedObserver.onError(error)
            }
            .disposed(by: disposeBag)
    }
}
