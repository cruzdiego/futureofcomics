//
//  ComicPanelGroupTableViewCell.swift
//  futureofcomics
//
//  Created by Diego Cruz on 2/23/18.
//  Copyright © 2018 Diego Cruz. All rights reserved.
//

import UIKit

class ComicPanelGroupTableViewCell: UITableViewCell {
    //MARK: - Private properties
    private var panelGroupView: ComicPanelGroupView?
    
    //MARK: - Public methods
    //MARK: UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.autoresizingMask = .flexibleHeight
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    public func configure(view: ComicPanelGroupView) {
        panelGroupView = view
        //Insert
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        //Constraints
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        //view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: view.frame.height/view.frame.width).isActive = true
    }
    
    public func react() {
        DispatchQueue.main.async {
            guard let panelViews = self.panelGroupView?.panelViews else {
                return
            }
            
            for panelView in panelViews {
                panelView.react()
            }
        }
    }
}
