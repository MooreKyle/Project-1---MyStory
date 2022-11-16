//
//  TaskCell.swift
//  PhotoScavengerHunt
//
//  Created by Mari Batilando on 11/15/22.
//

import Foundation
import UIKit

class TaskCell: UITableViewCell {
  static let identifier = "TaskCell"
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with task: Task) {
    textLabel?.text = task.title
    let imageView = UIImageView(image: UIImage(named: task.isCompleted ? "done" : "not-done")?.withRenderingMode(.alwaysTemplate))
    imageView.tintColor = task.isCompleted ? .systemGreen : .systemRed
    imageView.frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
    accessoryView = imageView
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    textLabel?.text = ""
  }
}
