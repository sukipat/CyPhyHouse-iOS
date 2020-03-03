//
//  ViewController.swift
//  CyPhyHouse
//
//  Created by Suki on 2/26/20.
//  Copyright © 2020 CSL. All rights reserved.
//

import UIKit

protocol ObjectDelegate {
    func objectWasSelected(coordinate: CGPoint, object: Object)
}

class ArenaViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Properties
    var arenaObjects = [Object]()
    var objectImages = [UIImageView]()
    var arenaView = UIView()
    let aspectRatio: CGFloat = 0.5
    let addObject = UIButton(type: .contactAdd)
    let addObjectViewController = AddObjectViewController()

    // MARK: - Init
    func setupView() {
        view.backgroundColor = UIColor.Appearance.LightBlue

        arenaView.backgroundColor = .white
        arenaView.translatesAutoresizingMaskIntoConstraints = false
        
        addObject.translatesAutoresizingMaskIntoConstraints = false
        addObject.tintColor = .white
        addObject.addTarget(self, action: #selector(didSelectAddObjectButton), for: .touchUpInside)
    }

    func layoutView() {
        view.addSubview(addObject)
        addObject.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        addObject.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        addObject.heightAnchor.constraint(equalToConstant: 32).isActive = true

        view.addSubview(arenaView)
        arenaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        arenaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        arenaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18).isActive = true
        arenaView.topAnchor.constraint(equalTo: addObject.bottomAnchor, constant: 20).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        layoutView()
    }

    // MARK: - Actions
    @objc func didSelectAddObjectButton() {
        addObjectViewController.modalPresentationStyle = .overCurrentContext
        addObjectViewController.transitioningDelegate = addObjectViewController
        addObjectViewController.delegate = self
        self.present(addObjectViewController, animated: true, completion: nil)
    }
    
    @objc func didPan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began || recognizer.state == .changed {
            let translation = recognizer.translation(in: arenaView)
            if let view = recognizer.view {
                view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            }
            recognizer.setTranslation(CGPoint.zero, in: arenaView)
        }
    }
}
// MARK: - ObjectDelegate
extension ArenaViewController: ObjectDelegate {
    func objectWasSelected(coordinate: CGPoint, object: Object) {
        let newImageView = UIImageView(frame: CGRect(x: coordinate.x, y: coordinate.y, width: 100, height: 100))
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(recognizer:)))
        newImageView.isUserInteractionEnabled = true
        newImageView.addGestureRecognizer(panRecognizer)

        switch object {
        case is DroneGoal:
            let newDrone = DroneGoal(location: coordinate)
            arenaObjects.append(newDrone)
            newImageView.image = newDrone.image
            arenaView.addSubview(newImageView)
        case is CarGoal:
            let newCar = CarGoal(location: coordinate)
            arenaObjects.append(newCar)
            newImageView.image = newCar.image
            arenaView.addSubview(newImageView)
        case is Obstacle:
            let newObstacle = Obstacle(location: coordinate, rad: 30)
            arenaObjects.append(newObstacle)
            newImageView.image = newObstacle.image
            arenaView.addSubview(newImageView)
        default:
            return
        }
        objectImages.append(newImageView)
    }
}

