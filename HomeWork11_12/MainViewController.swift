//
//  ViewController.swift
//  Home Work 11. Alamofire
//
//  Created by Maksim Grebenozhko on 27/08/2019.
//  Copyright © 2019 Maksim Grebenozhko. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var searchButton: UIButton!
    
    @IBOutlet private var scrollView: UIScrollView!
    
    private let segue = "segueResults"
    private let keyForCache = "title"
    
    //MARK: - Override meethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.cornerRadius = 5
        registerForKeyboardNotifications()
        
        if let title = UserDefaults.standard.value(forKey: keyForCache) {
            titleTextField.text = title as? String
        }
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    //MARK: - Actions
    
    @IBAction private func didSearchButton(_ sender: Any) {
        
        guard let searchText = titleTextField.text, !searchText.isEmpty else {
            wrongFormatAlert()
            return
        }
        
        UserDefaults.standard.set(titleTextField.text, forKey: keyForCache)
        
        performSegue(withIdentifier: segue, sender: self)
    }
    
    @IBAction func unwindToMainVC(_ sender: UIStoryboardSegue) {}
    
}

// MARK: - Private Methods

extension MainViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultsVC = segue.destination as! ResultsTableViewController
        
        guard let searchTitle = titleTextField.text else { return }
        resultsVC.fetchResultsFor(searchTitle)
    }
    
    private func wrongFormatAlert() {
        let alert = UIAlertController(
            title: "Wrong Format!",
            message: "Please enter correct title for search",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrameSize.height)
    }
    
    @objc private func keyboardWillHide() {
        scrollView.contentOffset = .zero
    }

}
