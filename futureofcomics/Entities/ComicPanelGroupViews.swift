//
//  ComicPanelGroupViews.swift
//  futureofcomics
//
//  Created by Diego Cruz on 2/23/18.
//  Copyright © 2018 Diego Cruz. All rights reserved.
//

import UIKit

class ComicPanelGroupViews {
    //MARK: - Properties
    //MARK: Public
    public static let shared = ComicPanelGroupViews()
    public let views:[ComicPanelGroupView] = Bundle.main.loadNibNamed("ComicPanelGroupViews", owner: nil, options: nil) as? [ComicPanelGroupView] ?? []
    
    //MARK: - Public methods
    //MARK: Util
    public func view(at index:Int) -> ComicPanelGroupView? {
        guard index < views.count else {
            return nil
        }
        
        return views[index]
    }
}
