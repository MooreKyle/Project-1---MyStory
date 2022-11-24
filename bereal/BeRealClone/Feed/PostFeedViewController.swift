//
//  PostFeedViewController.swift
//  BeRealClone
//
//  Created by Mari Batilando on 10/25/22.
//

import UIKit
import ParseSwift

enum SectionType: Int {
  case selfSection = 0
  case friends
}

class PostFeedViewController: UIViewController,
                              UITableViewDelegate,
                              UITableViewDataSource {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var logoutButton: UIButton!
  private let refreshControl = UIRefreshControl()
  
  private var posts = [Post]() {
    didSet {
      tableView.reloadData()
    }
  }
  
  // MARK: Lifecycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .black
    appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24.0)]
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "group"),
                                                       style: .plain,
                                                       target: nil,
                                                       action: nil)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.allowsSelection = false
    refreshControl.tintColor = .lightGray
    tableView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    queryPosts()
  }
  
  // MARK: Table View Methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == SectionType.selfSection.rawValue {
      return 1
    } else if section == SectionType.friends.rawValue {
      return posts.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case SectionType.selfSection.rawValue:
      return createSelfSectionCell(tableView, indexPath)
    case SectionType.friends.rawValue:
      return createFriendsCell(tableView, indexPath)
    default:
      return UITableViewCell()
    }
  }
  
  // MARK: IBActions
  
  @IBAction func didTapLogoutButton(_ sender: UIButton) {
    NotificationCenter.default.post(name: NSNotification.Name("logout"), object: nil)
  }
  
  // MARK: Private Methods
  
  @objc private func didPullToRefresh() {
    refreshControl.beginRefreshing()
    queryPosts { [unowned self] in
      self.refreshControl.endRefreshing()
    }
  }
  
  private func createSelfSectionCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SelfSectionCell", for: indexPath)
    return cell
  }
  
  private func createFriendsCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCellTableViewCell.identifier,
                                                   for: indexPath) as? PostCellTableViewCell else {
      return UITableViewCell()
    }
    cell.configure(withObject: posts[indexPath.row])
    return cell
  }
  
  private func queryPosts(completion: (() -> Void)? = nil) {
    let yesterday = Calendar.current.date(byAdding: .day,
                                          value: -1,
                                          to: Date())!
    let constraint: QueryConstraint = "createdAt" >= yesterday
    let query = Query<Post>([constraint])
      .include("user")
      .limit(10)
      .order([.descending("createdAt")])
    query.find { result in
      switch result {
      case .success(let posts):
        self.posts = posts
      case .failure(let error):
        print(error)
      }
      completion?()
    }
  }
}
