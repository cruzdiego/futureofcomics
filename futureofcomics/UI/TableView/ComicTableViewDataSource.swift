//
//  ComicTableViewDataSource.swift
//  futureofcomics
//
//  Created by Diego Cruz on 2/23/18.
//  Copyright © 2018 Diego Cruz. All rights reserved.
//

import UIKit

class ComicTableViewDataSource: NSObject {
    //MARK: - Public properties
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView? {
        didSet{
            didSetTableView()
        }
    }
    
    //MARK: Objects
    public var items = [ComicPanelGroupView]() {
        didSet {
            didSetItems()
        }
    }
    
    //MARK: - Private properties
    fileprivate enum Section:Int {
        case groups = 0
        
        var cell: Cell {
            switch self {
            case .groups:
                return .panelGroup
            }
        }
    }
    
    fileprivate enum Cell: String {
        case panelGroup = "panelGroupCell"
        
        var identifier: String {
            return self.rawValue
        }
        
        var cellClass: UITableViewCell.Type {
            switch self {
            case .panelGroup:
                return ComicPanelGroupTableViewCell.self
            }
        }
    }
    
    fileprivate var offsetCenterY: CGFloat {
        guard let scrollView = tableView else {
            return 0
        }
        
        let offsetY = scrollView.contentOffset.y
        return scrollView.center.y + offsetY
    }
    
    //MARK: - Private methods
    //MARK: didSet
    private func didSetTableView() {
        tableView?.estimatedRowHeight = 400
        tableView?.rowHeight = UITableViewAutomaticDimension
    }
    
    private func didSetItems() {
        tableView?.reloadData()
    }
}

//MARK: - Delegate methods
//MARK: UICollectionViewDataSource
extension ComicTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .groups:
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: section.cell.identifier, for: indexPath)
        
        //*** PanelGroupCell ***
        func configurePanelGroupCell() {
            guard   let cell = cell as? ComicPanelGroupTableViewCell,
                    indexPath.row < items.count else {
                return
            }
            
            let item = items[indexPath.row]
            cell.configure(view: item)
        }
        //**********************
        
        switch section {
        case .groups:
            configurePanelGroupCell()
        }
        
        return cell
    }
}

extension ComicTableViewDataSource: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let visiblePanelGroupCells = self.tableView?.visibleCells as? [ComicPanelGroupTableViewCell] else {
            return
        }
        
        for cell in visiblePanelGroupCells {
            cell.react()
        }
    }
}
