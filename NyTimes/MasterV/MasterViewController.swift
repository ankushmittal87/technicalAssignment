//
//  MasterViewController.swift
//  NyTimes
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    // MARK: - Properties
    private var viewModel: ArticleListViewModal!
    var detailViewController: DetailViewController?
    var objects = [Any]()
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    var connectionStatus: InternetStatus = .unAvailable {
        didSet {
            if connectionStatus == .available {
                updateView()
            } else {
               self.handleError(message: Strings.connectionUnavailable)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = ArticleListViewModal(manager: WebserviceManager())
        setUpBindings()
        setUpSpinner()
        spinner.startAnimating()
        if let split = splitViewController {
            let ctrls = split.viewControllers
            detailViewController = (ctrls[ctrls.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        assert(viewModel != nil, "ViewModel missing")
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        ReachabilityManager.shared.addListener(listener: self)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ReachabilityManager.shared.removeListener(listener: self)
    }
    // MARK: - Private Methods
    func updateView()  {
        viewModel.loadArticles()
    }
    func setUpBindings() {
        viewModel.didFetchArticles = { [weak self] in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
            self.spinner.stopAnimating()
            let initialIndexPath = NSIndexPath(row: 0, section: 0)
            if UIDevice.current.userInterfaceIdiom == .pad {
                self.tableView.selectRow(at: initialIndexPath as IndexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
                self.performSegue(withIdentifier: SegueIdentifiers.detail, sender: initialIndexPath)
            }
        }
        viewModel.failFetchArticles = { [weak self] (message) in
            guard let self = self else {
                return
            }
            self.spinner.stopAnimating()
            self.handleError(message: message)
        }
    }
    func handleError(message: String)  {
        let alert = UIAlertController(title: Strings.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.ok, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    func setUpSpinner() {
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        tableView.backgroundView = spinner
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.detail {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = viewModel.tableDataSource[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = (object.title, object.detailText, object.detailImageURL)
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
extension MasterViewController {
    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articleCount
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.newsCell) as! NewsTableViewCell
        let object = viewModel.tableDataSource[indexPath.row]
        cell.setDataNewsCell(title: object.title,
                             subTitle: object.author,
                             imagePath: object.thumbNailImage,
                             publishedDate: object.publishedDate)
        return cell
    }
}

extension MasterViewController: ReachibilityListeners {
    func internetStatus(status: InternetStatus) {
        switch status {
        case .available:
            connectionStatus = .available
        case .unAvailable:
            connectionStatus = .unAvailable
        }
    }
}
