import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourCollectionViewCell"
    
    private var tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "0°C"
        tempLabel.textColor = .white
        return tempLabel
    }()
    
    private var dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.text = "Day"
        dayLabel.textColor = .white
        return dayLabel
    }()
    
    private var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "00:00"
        timeLabel.textColor = .white
        return timeLabel
    }()
    
    private var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: "house")
        return iconImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tempLabel)
        addSubview(dayLabel)
        addSubview(timeLabel)
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 45),
            iconImageView.widthAnchor.constraint(equalToConstant: 45),
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(by: Forecast) {
        tempLabel.text = by.temp
        dayLabel.text = by.day
        timeLabel.text = by.hour
        iconImageView.image = UIImage(named: by.icon)
    }
    
}
