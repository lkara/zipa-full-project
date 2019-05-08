//
//  GarmentTableViewController.swift
//  zipa_final02
//
//  Created by Lydia Kara on 08/05/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit

struct Option<T> {
    let name: String
    let option: T
    let showsDisclosureIndicator: Bool
}

extension Option where T: RawRepresentable, T.RawValue == String {
    init(option: T, showsDisclosureIndicator: Bool = true) {
        self.name = option.rawValue
        self.option = option
        self.showsDisclosureIndicator = showsDisclosureIndicator
    }
}

class GarmentTableViewController<T>: UITableViewController {

    private let options: [Option<T>]
    var optionSelectionCallback: ((T) -> Void)?
    
    init(options: [Option<T>]) {
        self.options = options
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Option")
        
        let option = options[indexPath.row]
        cell.textLabel?.text = option.name
        cell.accessoryType = option.showsDisclosureIndicator ? .disclosureIndicator : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let option = options[indexPath.row]
        optionSelectionCallback?(option.option)
    }
    

}
