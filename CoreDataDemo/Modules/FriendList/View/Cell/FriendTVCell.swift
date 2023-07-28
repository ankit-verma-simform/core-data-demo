//
//  FriendTVCell.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 26/07/23.
//

import UIKit

/// Cell to display friend in table view
class FriendTVCell: UITableViewCell {

    // MARK: - IB Outlets

    @IBOutlet private weak var nameLabel: UILabel!

    // MARK: - View Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Functions
extension FriendTVCell {
    private func setupUI() {
        nameLabel.textColor = R.color.friendColor()
    }

    /// Configure friend cell with friend data
    /// - Parameter friend: friend instance
    func configure(with friend: Friend) {
        nameLabel.text = friend.name
    }
}
