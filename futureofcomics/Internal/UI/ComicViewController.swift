//
//  ViewController.swift
//  futureofcomics
//
//  Created by Diego Cruz on 2/23/18.
//  Copyright © 2018 Diego Cruz. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController {
    //MARK: - Properties
    //MARK: Public
    @IBOutlet var tableViewDataSource: ComicTableViewDataSource?
    
    //MARK: - Public methods
    //MARK: View events
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Private methods
    //MARK: Configure
    private func configure() {
        getComicGroupViews()
    }
    
    //MARK: Util
    private func getComicGroupViews() {
        tableViewDataSource?.items = ComicCanvas.shared.views
    }
}

