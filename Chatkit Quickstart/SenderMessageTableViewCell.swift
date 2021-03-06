import UIKit

class SenderMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.textAlignment = .right
        
        messageLabel.textAlignment = .right
        messageLabel.textColor = UIColor.white
        
        backgroundImageView.backgroundColor = CellColors.darkBackground
        backgroundImageView.layer.cornerRadius = 4.0
        backgroundImageView.clipsToBounds = true
    }
    
}

extension SenderMessageTableViewCell: MessageTableViewCell {

    func configure(senderName: String,
                   senderAvatarUrl: String?,
                   text: String,
                   backgroundColor: UIColor) {
        
        nameLabel.text = senderName
        messageLabel.text = text
        backgroundImageView.backgroundColor = backgroundColor
        avatarImageView.image = UIImage(named: "AvatarPlaceholder")
        
        if let senderAvatarUrlString = senderAvatarUrl,
            let senderAvatarUrl = URL(string: senderAvatarUrlString) {
    
            URLSession.shared.dataTask(with: senderAvatarUrl) { (data, _, _) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.avatarImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
}
