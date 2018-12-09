//
//  ParkerOnBoardViewController.swift
//  Parker
//
//  Created by Rdsn on 12/9/18.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

import Foundation
import Ahoy

class ParkerOnBoardViewController: OnboardingViewController {
	
	override func viewDidLoad() {
		presenter = ParkerPresenter()
		presenter.onOnBoardingFinished = { [weak self] in
			self?.dismiss(animated: true)
		}
		super.viewDidLoad()
	}
	
}

class ParkerPresenter: BasePresenter {
	
	override init() {
		super.init()
		// init slides
		model = [
			OnboardingSlide(titleText: "Before You Go",
							bodyText: "Since our app implemented several hidden gestures, we want to let you know so you can have a wondeful parking experience.",
							image: #imageLiteral(resourceName: "mainScreen")),
			OnboardingSlide(titleText: "Count Down Timer",
							bodyText: "Swipe left to get your countdown timer so you will never miss your meters parking or street parking limit.",
							image: #imageLiteral(resourceName: "SwipeRightToShowCountDownTime")),
			OnboardingSlide(titleText: "Clock Timer",
							bodyText: "Swipe right to start your clock timer so you can clearly know how long you have been parked.",
							image: #imageLiteral(resourceName: "SwipeRightToShowClock")),
			OnboardingSlide(titleText: "Camera",
							bodyText: "Swipe up to take a picture for your car or bike, and you will never miss where you parked.",
							image: #imageLiteral(resourceName: "SwipeUpToShowCamera "))
		]
		// init text setting
		doneButtonColor = .black
		doneButtonTextColor = .white
		cellBackgroundColor = .gray
		textColor = .white
		titleFont = UIFont(name: "Hoefler text", size: 28)!
		bodyFont = UIFont(name: "Hoefler text", size: 20)!
	}
	
	override func style(cell: UICollectionViewCell, for page: Int) {
		super.style(cell: cell, for: page)
		guard let cell = cell as? OnboardingCell else { return }
		cell.doneButton.layer.cornerRadius = cell.doneButton.frame.height / 2
		cell.doneButton.setTitle("Ready to park!", for: .normal)
	}
	
	override func visibilityChanged(for cell: UICollectionViewCell, at index: Int, amount: CGFloat) {
		guard let cell = cell as? OnboardingCell, index == pageCount - 1  else { return }
		cell.doneButtonBottomConstraint.constant = 60 * amount
		cell.setNeedsLayout()
		cell.layoutIfNeeded()
	}
	
}

