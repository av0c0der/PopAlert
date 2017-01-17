//
//  AlertController.swift
//  PopAlert
//
//  Created by Abdurahim Jauzee on 17/01/2017.
//  Copyright © 2017 Abdurahim Jauzee. All rights reserved.
//

import UIKit
import AsyncDisplayKit


class AlertController: ASViewController<ASDisplayNode> {
    
    var titles: [String]
    var tableNode = ASTableNode()
    var tableView: ASTableView { return tableNode.view }
    var dismissButton = ASButtonNode()
    
    init(with titles: [String]) {
        self.titles = titles
        super.init(node: ASDisplayNode())
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.titles = []
        super.init(coder: aDecoder)
    }
    
}

// MARK: - Lifecycle 🌎
extension AlertController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNodes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = UserDefaults.standard.object(forKey: kAlertOptionSaveTempKey) {
            let savedValue = UserDefaults.standard.integer(forKey: kAlertOptionSaveTempKey)
            let indexPath = IndexPath(row: savedValue, section: 0)
            tableNode.selectRow(at: indexPath,
                                animated: true,
                                scrollPosition: .none)
        }
    }
    
}

// MARK: - Actions ⚡
private extension AlertController {
    
    @objc func dismissButtonTapped(_ sender: ASButtonNode) {
        guard
            let window = UIApplication.shared.keyWindow,
            let root = window.rootViewController else { return }
        root.dismiss(animated: true)
    }
    
}

// MARK: - Setup ⛏
private extension AlertController {
    
    func setupNodes() {
        setupDismissButton()
        setupTableNode()
    }
    
    private func setupDismissButton() {
        node.addSubnode(dismissButton)
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped(_:)), forControlEvents: .touchUpInside)
    }
    
    private func setupTableNode() {
        node.addSubnode(tableNode)
        tableNode.backgroundColor = AlertController.appearance.backgroundColor
        tableNode.delegate = self
        tableNode.dataSource = self
        
        tableNode.clipsToBounds = false
        tableNode.backgroundColor = UIColor.white
        tableNode.layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
        tableNode.layer.shadowOffset = CGSize.zero
        tableNode.layer.shadowRadius = 50
        tableNode.layer.shadowOpacity = 1
        
        tableNode.layer.borderColor = UIColor.border.cgColor
        tableNode.layer.borderWidth = 1
        
        tableView.isScrollEnabled = false
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: tableContentInset, left: 0, bottom: tableContentInset, right: 0)
    }
    
}

// MARK: - Layout 🔬
extension AlertController {
    
    var cellHeight: CGFloat {
        return AlertController.appearance.elementHeight
    }
    
    var tableContentInset: CGFloat {
        return AlertController.appearance.elementsInset
    }
    
    var tableHeight: CGFloat {
        return CGFloat(titles.count) * cellHeight + tableContentInset * 2
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let maxHeight = UIScreen.main.bounds.height
        let sideInset = AlertController.appearance.containerSideInset
        let frame = CGRect(x: sideInset,
                           y: maxHeight / 2 - tableHeight / 2,
                           width: UIScreen.main.bounds.width - sideInset * 2,
                           height: tableHeight)
        tableNode.frame = frame
        dismissButton.frame = node.bounds
        tableNode.layer.shadowPath = UIBezierPath(rect: tableNode.bounds).cgPath
    }
    
}

// MARK: - Transition Delegate
extension AlertController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(presenting: false)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(presenting: true)
    }
    
}


// MARK: - TableView 📚
extension AlertController: ASTableDelegate, ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let title = titles[indexPath.row]
        let block = { () -> ASCellNode in
            let cell = AlertControllerCell(title: title)
            cell.style.preferredSize = CGSize(width: tableNode.bounds.width, height: AlertController.appearance.elementHeight)
            return cell
        }
        return block
    }
    
    func tableNode(_ tableNode: ASTableNode, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let node = tableNode.nodeForRow(at: indexPath) as? AlertControllerCell else { return indexPath }
        node.setupTitleNode(isSelected: false)
        return indexPath
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(indexPath.row, forKey: kAlertOptionSaveTempKey)
        UserDefaults.standard.synchronize()
    }
    
}
