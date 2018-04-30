//
//  ComicPanelGroupView.swift
//  futureofcomics
//
//  Created by Diego Cruz on 2/23/18.
//  Copyright © 2018 Diego Cruz. All rights reserved.
//

import UIKit

class ComicPanelGroupView: UIView {
    
    //MARK: - Public properties
    public var panelViews: [ComicPanelView] = []
    //MARK: Objects
    public var canReact: Bool {
        return panelViews.contains{$0.canReact}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        panelViews = subviews.compactMap{$0 as? ComicPanelView}
    }
}
