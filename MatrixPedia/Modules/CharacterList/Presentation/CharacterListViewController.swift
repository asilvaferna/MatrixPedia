//
//  CharacterListViewController.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit
import Alamofire

final class CharacterListViewController: UITableViewController {

    // MARK: - Private properties
    var characters: [CharacterViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    var presenter: CharacterListPresenter?

    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetup()

        presenter?.viewDidLoad()
    }

}

// MARK: - Private methods
private extension CharacterListViewController {
    func tableViewSetup() {
        self.title = "Characters"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
    }
}

// MARK: - UITableView Datasource & Delegate
extension CharacterListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: "characterCell")
            }
            return cell
        }()

        let character = characters[indexPath.row]
        cell.textLabel?.text = character.name
        cell.detailTextLabel?.text = character.type
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCharacter = characters[indexPath.row]
        presenter?.userDidSelectCharacter(withId: selectedCharacter.id)
    }
}

extension CharacterListViewController: CharacterListPresenterOutput {
    func loadCharacters(_ characters: [CharacterViewModel]) {
        self.characters = characters
    }

    func showError(message: String) {
        showErrorAlert(message: message)
    }
}
