//
//  EBookTableViewCell.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import UIKit

class EBookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
