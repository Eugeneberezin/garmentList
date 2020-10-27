//
//  AddViewController.swift
//  LululemonAssignment
//
//  Created by Eugene Berezin on 10/27/20.
//

import UIKit

protocol AddGarment {
    func addGarment(name: String)
}

class AddViewController: UIViewController {
    
    var delegate: AddGarment?
    let viewModel = GarmentViewModel()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Garment Name:"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    let textField: CustomTextField = {
        let textField = CustomTextField(padding: 5, height: 40)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Garment Name"
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray6.cgColor
        textField.layer.cornerRadius = 8
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func configureUI() {
        title = "ADD"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveItem))
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    @objc func saveItem() {
        if !(textField.text?.isEmpty ?? true) {
            delegate?.addGarment(name: textField.text!)
            navigationController?.popViewController(animated: true)
        }
    }

}
