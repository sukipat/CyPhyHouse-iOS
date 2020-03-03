//
//  AddObjectViewController.swift
//  CyPhyHouse
//
//  Created by Suki on 2/26/20.
//  Copyright © 2020 CSL. All rights reserved.
//

import Foundation
import UIKit

class AddObjectViewController: UIViewController {
    // MARK: - Properties
    let tableView = UITableView()
    let containerView = UIView()
    let objects = [DroneGoal(location: .zero), CarGoal(location: .zero), Obstacle(location: .zero, rad: .zero)]
    let background = UIView()
    var delegate: ObjectDelegate?

    // MARK: - Init
    func setupView() {
        let dismissalRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectDismiss))
    
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .clear
        background.addGestureRecognizer(dismissalRecognizer)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.Appearance.DarkBlue

        let objectSelectionRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectObject(recognizer:)))
        tableView.addGestureRecognizer(objectSelectionRecognizer)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ObjectCell.self, forCellReuseIdentifier: "objectCell")
        tableView.isScrollEnabled = false
    }
    
    func layoutView() {
        view.addSubview(background)
        background.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -32).isActive = true
        containerView.layer.cornerRadius = 32
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        
        containerView.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        tableView.contentInset = UIEdgeInsets(top: view.frame.height/8, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 32
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        layoutView()
    }
    
    @objc func didSelectObject(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: location) {
            delegate?.objectWasSelected(coordinate: recognizer.location(in: self.view.superview), object: objects[indexPath.row])
        }
        self.dismiss(animated: true, completion: nil)
        
    }

    @objc func didSelectDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - UITableViewDelegate
extension AddObjectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "objectCell", for: indexPath) as! ObjectCell
        cell.objectImage.image = objects[indexPath.row].image
        cell.selectionStyle = .none
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height / 4)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension AddObjectViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopinAnimator()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopoutAnimator()
    }
}
