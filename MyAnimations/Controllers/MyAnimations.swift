//
//  MyAnimations.swift
//  MyAnimations
//
//  Created by ruslan on 21.09.2021.
//

import UIKit

final class MyAnimations: UIViewController {
    
    private var animationType: AnimationType?
    private var animator: UIViewPropertyAnimator?
    private let square: UIView = {
        let label = UIView()
        label.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 50,
                             y: UIScreen.main.bounds.height / 2 - 50,
                             width: 100,
                             height: 100)
        label.backgroundColor = .systemPink
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let mySlider: UISlider = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        mySlider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
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
    private func configureAnimation(with type: AnimationType?) {
        guard let animationType = type else { return }
        
        view.addSubview(square)
        
        // choosing animation
        switch animationType {
        case .appearing:
            self.square.alpha = 0.0
            UIView.animate(withDuration: 2.0) {
                self.square.alpha = 1.0
            }
        case .coloring:
            UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: .calculationModeLinear) {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
                    self.square.backgroundColor = .systemRed
                }
                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                    self.square.backgroundColor = .systemYellow
                }
                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                    self.square.backgroundColor = .systemGreen
                }
            }
        case .centering:
            square.frame.origin.x = 10
            square.frame.origin.y = 100
            UIView.animate(withDuration: 2.0) {
                self.square.center = self.view.center
            }
        case .translation:
            UIView.animate(withDuration: 2.0) {
                self.square.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2 - 50, y: UIScreen.main.bounds.height / 2 - 50)
            }
        case .rotation:
            UIView.animate(withDuration: 2.0) {
                self.square.transform = CGAffineTransform(rotationAngle: .pi)
            }
        case .scaling:
            UIView.animate(withDuration: 2.0) {
                self.square.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
        case .identity:
            UIView.animate(withDuration: 1.0) {
                self.square.transform = CGAffineTransform(rotationAngle: .pi)
                    .scaledBy(x: 1.5, y: 1.5)
                    .translatedBy(x: 50, y: 50)
            } completion: { _ in
                UIView.animate(withDuration: 1.0) {
                    self.square.transform = .identity
                }
            }
        case .repeating:
            UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .repeat) {
                self.square.transform = CGAffineTransform(rotationAngle: -(3 * .pi) / 2)
            }
        case .reversing:
            UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .autoreverse) {
                self.square.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2 - 50, y: 0)
            } completion: { _ in
                self.square.isHidden = true
            }
        case .sequence:
            UIView.animateKeyframes(withDuration: 2.0, delay: 0.0, options: .calculationModeLinear, animations: {

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 125/1000) {
                    self.square.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2 - 50, y: 0)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 125/1000, relativeDuration: 250/1000) {
                    self.square.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2 - 50, y: UIScreen.main.bounds.height / 2 - 50)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 375/1000, relativeDuration: 250/1000) {
                    self.square.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width / 2 + 50, y: UIScreen.main.bounds.height / 2 - 50)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 625/1000, relativeDuration: 250/1000) {
                    self.square.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width / 2 + 50, y: 0)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 875/1000, relativeDuration: 125/1000) {
                    self.square.transform = .identity
                }
            })
        case .spring:
            UIView.animate(withDuration: 14.0,
                           delay: 1.0,
                           usingSpringWithDamping: 0.07,
                           initialSpringVelocity: 1.0,
                           options: .curveLinear) {
                self.square.transform = CGAffineTransform(translationX: 0, y: 100)
            }
        case .controlled:
            view.addSubview(mySlider)
            square.layer.cornerRadius = 50
            animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: {
                self.square.transform = CGAffineTransform(scaleX: 3.0, y: 3.0).rotated(by: -(3 * .pi) / 2)
                self.square.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                self.square.layer.cornerRadius = 0
            })
        case .tapGesture:
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
            square.addGestureRecognizer(tapGesture)
            animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut)
        }
    }
    
    // the animation cotrol
    @objc private func sliderValueDidChange(_ sender: UISlider) {
        guard let animator = animator else { return }
        animator.fractionComplete = CGFloat(sender.value) / 100
    }
    
    // start the animation by tapping
    @objc private func didTap() {
        guard let animator = animator else { return }
        animator.addAnimations {
            self.square.transform = CGAffineTransform(scaleX: 3.0, y: 3.0).rotated(by: -(3 * .pi) / 2)
            self.square.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            self.square.layer.cornerRadius = 0
        }
        animator.addCompletion { _ in
            self.square.alpha = 0.0
        }
        animator.startAnimation()
    }
}
