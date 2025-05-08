import UIKit
import SnapKit

final class ChatTableViewCell: UITableViewCell {

    static let identifier = "ChatTableViewCell"

    private let profileImageView = UIImageView()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()

    private let placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()

    private let chatLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()

    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile1")
        return imageView
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        [profileImageView, nameLabel, placeLabel, chatLabel, itemImageView]
            .forEach { contentView.addSubview($0) }

        profileImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
            $0.size.equalTo(40)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().offset(16.5)
        }
        placeLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(4)
            $0.top.equalTo(nameLabel).offset(2)
        }
        chatLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(nameLabel)
        }
        itemImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(16)
            $0.size.equalTo(40)
        }
    }

    func dataBind(_ chatData: ChatModel) {
        profileImageView.image = chatData.profileImg
        nameLabel.text = chatData.name
        placeLabel.text = chatData.place
        chatLabel.text = chatData.message
        itemImageView.image = chatData.itemImg
    }
}
