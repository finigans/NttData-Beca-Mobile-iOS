//
//  ListaFilmesTableViewController.swift
//  Beca-Jonathan
//
//  Created by Jonathan Pereira Almeida on 16/02/22.
//

import Foundation


import UIKit
import Alamofire

class ListaFilmesTableViewController: UITableViewController {

  var list: [Result] = []
  var images: [UIImage] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
    }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let controller = segue.destination as! DetalhesViewController
    let selectedRow = list[tableView.indexPathForSelectedRow!.row]
    controller.movie = selectedRow
  }
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PosterTableViewCell
        let movie = list[indexPath.row]
        cell.preencheViews(result: movie)
        return cell
    }
  
    func loadData(){
      API.loadMovies { (info) in
        if let info = info{
          self.list += info.results
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
        }
      }
    }
    
  
  