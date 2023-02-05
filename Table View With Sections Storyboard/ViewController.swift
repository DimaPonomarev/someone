//
//  ViewController.swift
//  Table View With Sections Storyboard
//
//  Created by Дмитрий Пономарев on 17.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    //    MARK: - UI Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    //  MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //  MARK: - IBAction

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newPatternVC = segue.source as? NewPatternViewController else { return }
        newPatternVC.saveNewPattern()
        Pattern.patterns.append(newPatternVC.newPattern!)
        tableView.reloadData()
    }
}

//  MARK: - extension UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Pattern.patterns.map {$0}[section].names.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Pattern.patterns.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let nameOfSection = Pattern.patterns.map { $0.title }[section]
        return nameOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomTableViewCell
        cell?.labelForCell.text = Pattern.patterns.map {$0.names}[indexPath.section][indexPath.row]
        cell?.imageForCell.image = UIImage(named: Pattern.patterns.map {$0.names}[indexPath.section][indexPath.row])
        return cell!
    }
}

//  MARK: - extension UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
}

