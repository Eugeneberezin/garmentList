//
//  ViewController.swift
//  LululemonAssignment
//
//  Created by Eugene Berezin on 10/27/20.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Alpha", "Creation Time"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSegmentedControll), for: .valueChanged)
        return sc
    }()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let viewModel = GarmentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.retrieveData()
        tableView.reloadData()
        
    }
    
    private func configureUI() {
        title = "List"
        viewModel.garmentsList = viewModel.garmentsList.sorted { $0.garmentName.lowercased() < $1.garmentName.lowercased() }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(handAdd))
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(segmentedControl)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "garmentCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func handleSegmentedControll() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            viewModel.garmentsList = viewModel.garmentsList.sorted { $0.garmentName.lowercased() < $1.garmentName.lowercased() }
            tableView.reloadData()
        default:
            viewModel.garmentsList = viewModel.garmentsList.sorted(by: { $0.addedDate.compare($1.addedDate) == .orderedDescending })
        }
        tableView.reloadData()
        
    }
    
    @objc func handAdd() {
        let addVC = AddViewController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
        
    }


}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.garmentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "garmentCell", for: indexPath)
        cell.backgroundColor = .tertiarySystemBackground
        cell.textLabel?.text = viewModel.garmentsList[indexPath.row].garmentName
        
        return cell
    }
    
}

extension ListViewController: AddGarment {

    func addGarment(name: String) {
        viewModel.garmentsList.append(Garments(garmentName: name))
        viewModel.saveData(garmentName: name)
        viewModel.garmentsList = viewModel.garmentsList.sorted { $0.garmentName.lowercased() < $1.garmentName.lowercased() }
        tableView.reloadData()
    }

}
