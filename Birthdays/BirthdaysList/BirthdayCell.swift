//
//  BirthdayCell.swift
//  Birthdays
//
//  Created by dasdom on 30.08.15.
//  Copyright © 2015 dasdom. All rights reserved.
//

import UIKit

class BirthdayCell: UITableViewCell {

  let patternView: UIView
  let nameLabel: UILabel
  let patternNameLabel: UILabel
  let birthdayLabel: UILabel
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
    patternView = UIView()
    patternView.translatesAutoresizingMaskIntoConstraints = false
    patternView.clipsToBounds = true
    
    nameLabel = UILabel()
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = .systemFontOfSize(30)
    
    patternNameLabel = UILabel()
    patternNameLabel.translatesAutoresizingMaskIntoConstraints = false
    patternNameLabel.font = nameLabel.font
    patternNameLabel.textColor = .whiteColor()
    
    birthdayLabel = UILabel()
    birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    patternView.backgroundColor = UIColor(patternImage: UIImage(named: "cellBackgroundPattern")!)
    
    addSubview(nameLabel)
    addSubview(birthdayLabel)
    addSubview(patternView)
    patternView.addSubview(patternNameLabel)
    
    let views = ["pattern": patternView, "name": nameLabel, "birthday": birthdayLabel]
    var layoutConstraints = [NSLayoutConstraint]()
    
    layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("|[pattern]", options: [], metrics: nil, views: views)
    layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[pattern]|", options: [], metrics: nil, views: views)
    layoutConstraints.append(patternView.trailingAnchor.constraintEqualToAnchor(trailingAnchor, constant: -150))
    layoutConstraints.append(nameLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
    layoutConstraints.append(nameLabel.centerYAnchor.constraintEqualToAnchor(centerYAnchor))
    layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("[birthday]-|", options: [], metrics: nil, views: views)
    layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:[birthday]|", options: [], metrics: nil, views: views)
    
    layoutConstraints.append(patternNameLabel.leadingAnchor.constraintEqualToAnchor(nameLabel.leadingAnchor))
    layoutConstraints.append(patternNameLabel.centerYAnchor.constraintEqualToAnchor(nameLabel.centerYAnchor))
    
    NSLayoutConstraint.activateConstraints(layoutConstraints)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
