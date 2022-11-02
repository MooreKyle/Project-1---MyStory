//
//  PostFeedViewController.swift
//  BeRealClone
//
//  Created by Mari Batilando on 10/25/22.
//

import UIKit
import Parse

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
  
  private var posts = [PFObject]() {
    didSet {
      tableView.reloadData()
    }
  }
  
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
  
  @objc private func didPullToRefresh() {
    refreshControl.beginRefreshing()
    queryPosts { [unowned self] in
      self.refreshControl.endRefreshing()
    }
  }
  
  @IBAction func didTapLogoutButton(_ sender: UIButton) {
    NotificationCenter.default.post(name: NSNotification.Name("logout"), object: nil)
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
    let query = PFQuery(className: "Post")
    query.includeKey("user")
    query.addDescendingOrder("createdAt")
    query.findObjectsInBackground { [unowned self] posts, error in
      if let error = error {
        print("Error in fetching messages: \(error.localizedDescription)")
      } else {
        self.posts = posts ?? []
      }
      completion?()
    }
  }
}
