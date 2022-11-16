//
//  ViewController.swift
//  PhotoScavengerHunt
//
//  Created by Mari Batilando on 11/15/22.
//

import UIKit

class TaskListViewController: UITableViewController {
  private let tasks = HARDCODED_TASKS
  private let kShowtaskDetailSegueIdentifier = "ShowTaskDetailSegue"
  private var selectedTask: Task?

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Photo Scavenger Hunt"
    navigationItem.backButtonTitle = ""
    tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
    cell.configure(with: tasks[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedTask = tasks[indexPath.row]
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: kShowtaskDetailSegueIdentifier, sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == kShowtaskDetailSegueIdentifier else { return }
    let viewController = segue.destination as! TaskDetailViewController
    viewController.task = selectedTask
  }
}

