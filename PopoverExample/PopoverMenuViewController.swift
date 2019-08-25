//
//  PopoverMenuViewController.swift
//  PopoverExample
//
//  Created by Hajime Imamura on 2019/08/25.
//  Copyright © 2019 imamurh. All rights reserved.
//

import UIKit

final class PopoverMenuViewController: UIViewController {

    typealias OnMenuItemSelected = (String) -> Void

    var onMenuItemSelected: OnMenuItemSelected?

    class func instantiate(onMenuItemSelected: OnMenuItemSelected? = nil) -> PopoverMenuViewController {
        let vc = UIStoryboard(name: "PopoverMenuViewController", bundle: nil).instantiateInitialViewController() as! PopoverMenuViewController
        vc.onMenuItemSelected = onMenuItemSelected
        return vc
    }

    enum Row {
        case menuItem(text: String)
        case separator(height: CGFloat)
        case space(height: CGFloat)

        var height: CGFloat {
            switch self {
            case .menuItem: return 40
            case .separator(let height): return height
            case .space(let height): return height
            }
        }
    }

    lazy var rows: [Row] = {
        return [
            .space(height: 20),
            .menuItem(text: "🐶イッヌ"),
            .menuItem(text: "🐶イッヌ"),
            .menuItem(text: "🐶イッヌ"),
            .space(height: 20),
            .separator(height: 2),
            .space(height: 20),
            .menuItem(text: "🐱ネッコ"),
            .menuItem(text: "🐱ネッコ"),
            .menuItem(text: "🐱ネッコ"),
            .space(height: 20),
            .separator(height: 2),
            .space(height: 20),
            .menuItem(text: "🐶イッヌ"),
            .menuItem(text: "🐶イッヌ"),
            .space(height: 20),
            .separator(height: 2),
            .space(height: 20),
            .menuItem(text: "🐱ネッコ"),
            .menuItem(text: "🐱ネッコ"),
            .space(height: 20)
        ]
    }()

    private var _preferredContentSize: CGSize = .zero
    override var preferredContentSize: CGSize {
        set {
            _preferredContentSize = newValue
        }
        get {
            guard _preferredContentSize == .zero else { return _preferredContentSize }
            return CGSize(width: 300, height: totalHeight)
        }
    }

    private var totalHeight: CGFloat {
        return rows.reduce(0) { $0 + $1.height }
    }

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.isScrollEnabled = tableView.bounds.size.height != totalHeight
    }
}

extension PopoverMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch rows[indexPath.row] {
        case .menuItem(let text):
            cell = tableView.dequeueReusableCell(withIdentifier: "menuItem", for: indexPath)
            cell.textLabel?.text = text
        case .separator:
            cell = tableView.dequeueReusableCell(withIdentifier: "separator", for: indexPath)
        case .space:
            cell = tableView.dequeueReusableCell(withIdentifier: "space", for: indexPath)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rows[indexPath.row].height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case .menuItem(let text) = rows[indexPath.row] else { return }
        onMenuItemSelected?(text)
    }
}
