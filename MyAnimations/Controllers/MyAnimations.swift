//
//  MyAnimations.swift
//  MyAnimations
//
//  Created by ruslan on 21.09.2021.
//

import UIKit

final class MyAnimations: UIViewController {
    
    private var animationType: AnimationType!
    private var animator: UIViewPropertyAnimator?
    private var isFinished = false
    
    private weak var myView: UIView!
    private weak var mySlider: UISlider!
    private weak var myButton: UIButton!
    
    private var smallViewConstraints: [NSLayoutConstraint]!
    private var fullScreenViewConstraints: [NSLayoutConstraint]!
    
    // MARK: - Load view
    override func loadView() {
        super.loadView()
        
        let myView: UIView = {
            let view = UIView()
            view.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 50,
                                 y: UIScreen.main.bounds.height / 2 - 50,
                                 width: 100,
                                 height: 100)
            view.clipsToBounds = true
            view.layer.cornerRadius = 20
            return view
        }()
        
        let mySlider: UISlider = {
            let slider = UISlider()
            slider.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100,
                                  y: UIScreen.main.bounds.height / 2 + 200,
                                  width: 200,
                                  height: 50)
            slider.maximumValue = 100.0
            slider.minimumValue = 0.0
            slider.value = 0.0
            return slider
        }()
        
        let myButton: UIButton = {
            let button = UIButton()
            button.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100,
                                  y: UIScreen.main.bounds.height / 2 + 150,
                                  width: 200,
                                  height: 50)
            button.setTitle("Change", for: .normal)
            button.layer.cornerRadius = 16
            return button
        }()
        
        fullScreenViewConstraints = [
            myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myView.topAnchor.constraint(equalTo: view.topAnchor),
            myView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        smallViewConstraints = [
            myView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myView.widthAnchor.constraint(equalToConstant: 100),
            myView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        view.addSubview(myView)
        if animationType == .controlled {
            view.addSubview(mySlider)
        } else if animationType == .constraints {
            myView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(myButton)
        }
        
        self.myView = myView
        self.mySlider = mySlider
        self.myButton = myButton
    }
    
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.backgroundColor = .systemPink
        if let button = myButton {
            button.backgroundColor = .systemPurple
        }
        view.backgroundColor = .systemBackground
        
        configureAnimation(with: animationType)
    }
    
    // stopping the controlled animation before quit
    override func viewWillDisappear(_ animated: Bool) {
        guard let animator = animator else { return }
        animator.stopAnimation(true)
    }
    
    // MARK: - Init
    init(title: String, animationType: AnimationType) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.animationType = animationType
        self.animator = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Animation configuring
    private func configureAnimation(with type: AnimationType) {
        
        // choosing animation
        switch animationType {
        case .appearing:
            self.myView.alpha = 0.0
            UIView.animate(withDuration: 2.0) {
                self.myView.alpha = 1.0
            }
        case .coloring:
            UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: .calculationModeLinear) {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
                    self.myView.backgroundColor = .systemRed
                }
                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                    self.myView.backgroundColor = .systemYellow
                }
                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                    self.myView.backgroundColor = .systemGreen
                }
            }
        case .centering:
            myView.frame.origin.x = 10
            myView.frame.origin.y = 100
            UIView.animate(withDuration: 2.0) {
                self.myView.center = self.view.center
            }
        case .translation:
            UIView.animate(withDuration: 2.0) {
                self.myView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2 - 50, y: UIScreen.main.bounds.height / 2 - 50)
            }
        case .rotation:
            UIView.animate(withDuration: 2.0) {
                self.myView.transform = CGAffineTransform(rotationAngle: .pi)
            }
        case .scaling:
            UIView.animate(withDuration: 2.0) {
                self.myView.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
        case .identity:
            UIView.animate(withDuration: 1.0) {
                self.myView.transform = CGAffineTransform(rotationAngle: .pi)
                    .scaledBy(x: 1.5, y: 1.5)
                    .translatedBy(x: 50, y: 50)
            } completion: { _ in
                UIView.animate(withDuration: 1.0) {
                    self.myView.transform = .identity
                }
            }
        case .repeating:
            UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .repeat) {
                self.myView.transform = CGAffineTransform(rotationAngle: -(3 * .pi) / 2)
            }
        case .reversing:
            UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .autoreverse) {
                self.myView.transform = CGAffineTransform(rotationAngle: -(3 * .pi) / 2)
            }
        case .sequence:
            UIView.animateKeyframes(withDuration: 2.0, delay: 0.0, options: .calculationModeLinear, animations: {

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 125/1000) {
                    self.myView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2 - 50, y: 0)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 125/1000, relativeDuration: 250/1000) {
                    self.myView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2 - 50, y: UIScreen.main.bounds.height / 2 - 50)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 375/1000, relativeDuration: 250/1000) {
                    self.myView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width / 2 + 50, y: UIScreen.main.bounds.height / 2 - 50)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 625/1000, relativeDuration: 250/1000) {
                    self.myView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width / 2 + 50, y: 0)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 875/1000, relativeDuration: 125/1000) {
                    self.myView.transform = .identity
                }
            })
        case .spring:
            UIView.animate(withDuration: 14.0,
                           delay: 1.0,
                           usingSpringWithDamping: 0.07,
                           initialSpringVelocity: 1.0,
                           options: .curveLinear) {
                self.myView.transform = CGAffineTransform(translationX: 0, y: 100)
            }
        case .controlled:
            myView.layer.cornerRadius = 50
            mySlider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
            animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: {
                self.myView.transform = CGAffineTransform(scaleX: 3.0, y: 3.0).rotated(by: -(3 * .pi) / 2)
                self.myView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                self.myView.layer.cornerRadius = 0
            })
        case .tapGesture:
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
            myView.addGestureRecognizer(tapGesture)
            animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut)
        case .moving:
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
            panGesture.name = "moving"
            myView.addGestureRecognizer(panGesture)
            animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut)
        case .panGesture:
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
            panGesture.name = "panGesture"
            myView.addGestureRecognizer(panGesture)
            animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: {
                self.myView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.myView.backgroundColor = .cyan
            })
        case .constraints:
            myButton.addTarget(self, action: #selector(buttonDidTouched), for: .touchUpInside)
            NSLayoutConstraint.activate(smallViewConstraints)
        case .none:
            break
        }
    }
    
    // MARK: - Objc functions
    
    // animating the constraint changes by button touches
    @objc private func buttonDidTouched() {
        func animateView() {
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            } completion: { isFinished in
                self.isFinished.toggle()
            }
        }
        
        if isFinished {
            NSLayoutConstraint.deactivate(fullScreenViewConstraints)
            NSLayoutConstraint.activate(smallViewConstraints)
            animateView()
        } else {
            NSLayoutConstraint.deactivate(smallViewConstraints)
            NSLayoutConstraint.activate(fullScreenViewConstraints)
            animateView()
        }
    }
    
    // the animation control
    @objc private func sliderValueDidChange(_ sender: UISlider) {
        guard let animator = animator else { return }
        animator.fractionComplete = CGFloat(sender.value) / 100
    }
    
    // start the animation by tapping
    @objc private func didTap() {
        guard let animator = animator else { return }
        animator.addAnimations {
            self.myView.transform = CGAffineTransform(scaleX: 3.0, y: 3.0).rotated(by: -(3 * .pi) / 2)
            self.myView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            self.myView.layer.cornerRadius = 0
        }
        animator.addCompletion { _ in
            self.myView.alpha = 0.0
        }
        animator.startAnimation()
    }
    
    // the animation by a pan gesture
    @objc private func didPan(_ panGesture: UIPanGestureRecognizer) {
        guard let animator = animator else { return }
        if panGesture.name == "moving" {
            let newPosition = panGesture.translation(in: self.view)
            let currentX = myView.center.x
            let currentY = myView.center.y
            myView.center = CGPoint(x: currentX + newPosition.x, y: currentY + newPosition.y)
            panGesture.setTranslation(.zero, in: self.view)
            animator.startAnimation()
        } else {
            let translation = panGesture.translation(in: self.view)
            let final = (view.bounds.height - myView.bounds.height) / 2
            
            switch panGesture.state {
            case .began:
                animator.startAnimation()
                animator.pauseAnimation()
            case .changed:
                animator.fractionComplete = -translation.y / final
                animator.pauseAnimation()
            case .ended:
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0.0)
            default: break
            }
        }
    }
}
