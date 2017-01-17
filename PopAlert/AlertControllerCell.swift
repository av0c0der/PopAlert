//
//  AlertControllerCell.swift
//  PopAlert
//
//  Created by Abdurahim Jauzee on 17/01/2017.
//  Copyright © 2017 Abdurahim Jauzee. All rights reserved.
//

import AsyncDisplayKit


class AlertControllerCell: ASCellNode {
    
    fileprivate let title: String
    fileprivate let titleNode = ASTextNode()
    
    init(title: String) {
        self.title = title
        super.init()
        automaticallyManagesSubnodes = true
        setupTitleNode()
    }
    
    override func didLoad() {
        super.didLoad()
        selectionStyle = .default
    }
        
}

// MARK: - Setup ⛏
extension AlertControllerCell {
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        } set {
            backgroundColor = newValue ? AlertController.appearance.tintColor : AlertController.appearance.backgroundColor
            setupTitleNode(isSelected: newValue)
        }
    }
    
    func setupTitleNode(isSelected: Bool = false) {
        let attributedText = NSMutableAttributedString(string: title)
        let range = NSMakeRange(0, title.utf8.count)

        attributedText.addAttributes([
            NSFontAttributeName : AlertController.appearance.font,
            NSForegroundColorAttributeName : (isSelected ? AlertController.appearance.activeTextColor : AlertController.appearance.inactiveTextColor)
            ], range: range)
        titleNode.attributedText = attributedText
    }
    
}

// MARK: - Layout 🔬
extension AlertControllerCell {
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let centerSpec = ASCenterLayoutSpec(centeringOptions: .XY,
                                            sizingOptions: .minimumXY,
                                            child: titleNode)
        return centerSpec
    }
    
}
