//
//  EBookTableViewCell.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import UIKit

class EBookTableViewCell: UITableViewCell {

    @IBOutlet private weak var bookCoverImageView: UIImageView!
    @IBOutlet private weak var bookTitleLabel: UILabel!
    @IBOutlet private weak var bookAuthorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(displayedEBook: ListingPage.DisplayedEBook) {
        self.bookCoverImageView.download(image: displayedEBook.artworkUrl60 ?? "")
        self.bookTitleLabel.text = displayedEBook.title
        self.bookAuthorLabel.text = displayedEBook.author
    }
}
