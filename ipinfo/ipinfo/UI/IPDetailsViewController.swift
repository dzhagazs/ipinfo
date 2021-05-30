//
//  IPDetailsViewController.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import UIKit

protocol CellConfigurable {
    var reuseIdentifier: String { get }
    func configure(cell: UITableViewCell)
}

fileprivate let cellReuseIdentifier = "cell"

class IPDetailsViewController: UIViewController, UITableViewDataSource, IPDetailsViewModelPresenter {
    
    private var rows: [IPDetailsRowModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 50
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else { return UITableViewCell() }
        let model = rows[indexPath.row]
        model.configure(cell: cell)
        return cell
    }
    
    // MARK: IPDetailsViewModelPresenter
    
    var viewModel: IPDetailsViewModelProtocol? {
        didSet {
            viewModel?.presenter = self
        }
    }
    
    func show(rows: [IPDetailsRowModel]) {
        self.rows = rows
    }
}

extension IPDetailsRowModel: CellConfigurable {
    
    var reuseIdentifier: String { cellReuseIdentifier }
    
    func configure(cell: UITableViewCell) {
        let attrText = NSMutableAttributedString(string: data.key + ": ", attributes: [.foregroundColor: UIColor.keyColor])
        attrText.append(NSAttributedString(string: data.value.stringValue, attributes: [.foregroundColor: data.value.valueColor]))
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.attributedText = attrText
    }
}

extension IPModelFieldValue {
    var valueColor: UIColor {
        switch self {
            case .bool(_): return UIColor.boolValueColor
            case .string(_): return UIColor.stringValueColor
            case .number(_): return UIColor.numberValueColor
        }
    }
}
