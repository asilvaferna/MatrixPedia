//
//  CharacterListViewController.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit
import Alamofire

class CharacterListViewController: UITableViewController {

    var characters: [MatrixCharacter] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetup()

        loadCharacters()
    }

}

private extension CharacterListViewController {
    func tableViewSetup() {
        self.title = "Characters"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
    }

    func loadCharacters() {
        Alamofire
            .request("http://127.0.0.1/characters")
            .responseJSON { [weak self] response in
                if let data = response.data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments), let characters = jsonData as? [[String: Any]] {
                    var newCharacters = [MatrixCharacter]()
                    characters.forEach { character in
                        guard let newCharacter = MatrixCharacter(json: character) else { return }
                        newCharacters.append(newCharacter)
                    }

                    self?.characters = newCharacters
                }
            }
    }
}

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
        cell.textLabel?.text = character.alias
        cell.detailTextLabel?.text = character.type.rawValue.capitalized
        return cell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedCharacter = characters[indexPath.row]
//        let characterProfileViewController = CharacterProfileViewController(withCharacterId: characterSelected.id)
//        navigationController?.pushViewController(characterProfileViewController, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
}
