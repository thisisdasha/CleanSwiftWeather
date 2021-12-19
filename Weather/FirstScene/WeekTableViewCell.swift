//
//  WeekTableViewCell.swift
//  Weather
//
//  Created by Daria Tokareva on 19.12.2021.
//

import UIKit

class WeekTableViewCell: UITableViewCell {

    static let identifier = "WeekTableViewCell"
    
    private var dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.text = "Day"
        dayLabel.textColor = .blue
        return dayLabel
    }()
    
    private var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "00:00"
        timeLabel.textColor = .blue
        return timeLabel
    }()
    
    private var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: "house")
        return iconImageView
    }()
    
    private var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.textColor = .blue
        return descriptionLabel
    }()
    
    private var tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "0°C"
        tempLabel.textColor = .blue
        return tempLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(dayLabel)
        addSubview(timeLabel)
        addSubview(iconImageView)
        addSubview(descriptionLabel)
        addSubview(tempLabel)
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            timeLabel.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 8),
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 45),
            iconImageView.widthAnchor.constraint(equalToConstant: 45),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            descriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 32),
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            tempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(by: Forecast) {
        tempLabel.text = by.temp
        dayLabel.text = by.day
        timeLabel.text = by.hour
        descriptionLabel.text = by.description
        iconImageView.image = UIImage(named: by.icon)
    }
}
