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
    //MARK: IBOutlet
    @IBOutlet var panelViews: [ComicPanelView]?
    //MARK: Objects
    public var canReact: Bool {
        guard let panelViews = panelViews else {
            return false
        }
        
        return panelViews.contains{$0.canReact}
    }
}
