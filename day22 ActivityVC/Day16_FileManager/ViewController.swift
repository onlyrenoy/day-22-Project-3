//
//  ViewController.swift
//  Day16_FileManager
//
//  Created by Renoy on 14/10/2019.
//  Copyright © 2019 Renoy. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {


    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareWithFriends))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                pictures.sort()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pictures",for: indexPath)
       
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25.0)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedPageNumber = indexPath.row + 1
            vc.numberOfPages = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc
    private func shareWithFriends() {
        let link = "Share this pls"
        let viewController = UIActivityViewController(activityItems: [link], applicationActivities: [])
        
        present(viewController, animated: true)
    }

}

