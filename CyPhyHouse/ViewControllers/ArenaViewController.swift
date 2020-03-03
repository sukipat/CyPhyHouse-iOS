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

class ArenaViewController: UIViewController {
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
    func removeImageViewAt(center: CGPoint) {
        for (index, image) in objectImages.enumerated() {
            if (image.center == center) {
                arenaObjects.remove(at: index)
                objectImages.remove(at: index)
                break
            }
        }
    }
    @objc func didSelectAddObjectButton() {
        addObjectViewController.modalPresentationStyle = .overCurrentContext
        addObjectViewController.transitioningDelegate = addObjectViewController
        addObjectViewController.delegate = self
        self.present(addObjectViewController, animated: true, completion: nil)
    }
    
    @objc func didPan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began || recognizer.state == .changed {
            let translation = recognizer.translation(in: view)
            if let viewToDrag = recognizer.view {
                viewToDrag.center = CGPoint(x: viewToDrag.center.x + translation.x, y: viewToDrag.center.y + translation.y)
            }
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
        
        if recognizer.state == .ended {
            if let viewToDrag = recognizer.view {
                let newCenter = viewToDrag.center
                if !arenaView.frame.contains(newCenter) {
                    viewToDrag.removeFromSuperview()
                    removeImageViewAt(center: newCenter)
                }
            }
        }
    }

    @objc func didPinch(recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .ended || recognizer.state == .changed {
            if let pinchedView = recognizer.view {
                let currentScale = pinchedView.frame.size.width / pinchedView.bounds.size.width
                var newScale = currentScale*recognizer.scale

                newScale = newScale < 1 ? 1 : newScale
                newScale = newScale > 3 ? 3 : newScale

                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                pinchedView.transform = transform

                recognizer.scale = 1
            }
        }
    }
}
// MARK: - ObjectDelegate
extension ArenaViewController: ObjectDelegate {
    func objectWasSelected(coordinate: CGPoint, object: Object) {
        let defaultWidth: CGFloat = 100.0

        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(recognizer:)))
        panRecognizer.delegate = self

        let newImageView = UIImageView()
        newImageView.bounds = CGRect(x: 0, y: 0, width: defaultWidth, height: defaultWidth)
        newImageView.center = coordinate
        newImageView.isUserInteractionEnabled = true
        newImageView.addGestureRecognizer(panRecognizer)

        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(recognizer:)))

        switch object {
        case is DroneGoal:
            let newDrone = DroneGoal(location: coordinate)
            arenaObjects.append(newDrone)
            newImageView.image = newDrone.image
            view.addSubview(newImageView)
            objectImages.append(newImageView)
        case is CarGoal:
            let newCar = CarGoal(location: coordinate)
            arenaObjects.append(newCar)
            newImageView.image = newCar.image
            view.addSubview(newImageView)
            objectImages.append(newImageView)
        case is Obstacle:
            let newObstacle = Obstacle(location: coordinate, rad: defaultWidth/2)
            arenaObjects.append(newObstacle)
            newImageView.image = newObstacle.image
            newImageView.addGestureRecognizer(pinchRecognizer)
            view.addSubview(newImageView)
            objectImages.append(newImageView)
        default:
            return
        }
    }
}
// MARK: - UIGestureRecognizerDelegate
extension ArenaViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

