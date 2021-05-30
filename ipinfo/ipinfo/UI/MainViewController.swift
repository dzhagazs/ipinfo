//
//  MainViewController.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import UIKit

class MainViewController: UIViewController, MainViewModelPresenter, UITextFieldDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
            activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.viewDidLoad()
    }

    // MARK: IBActions
    
    @IBAction func searchAction(_ sender: Any) {
        viewModel?.searchAction()
    }
    
    // MARK: MainViewModelPresenter
    
    var viewModel: MainViewModelProtocol? {
        didSet {
            viewModel?.presenter = self
        }
    }
    
    func update(title: String) {
        titleLabel.text = title
    }
    
    func update(subtitle: String) {
        subtitleLabel.text = subtitle
    }
    
    func update(searchButtonTitle: String) {
        searchButton.setTitle(searchButtonTitle, for: .normal)
    }
    
    func update(searchText: String) {
        textField.text = searchText
    }
    
    func setSearch(enabled: Bool) {
        searchButton.isEnabled = enabled
    }
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
        searchButton.isUserInteractionEnabled = false
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
        searchButton.isUserInteractionEnabled = true
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        let shouldHandle = viewModel?.shouldHandleInput(text: result) ?? false
        if shouldHandle {
            try? viewModel?.handleInput(text: result)
        }
        return shouldHandle
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
