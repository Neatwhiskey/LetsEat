//
//  LocationViewController.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 02/02/2024.
//

import UIKit

class LocationViewController: UIViewController{

    @IBOutlet var tableView: UITableView!
    
    let manager = LocationManager()
    var selectedCity: LocationItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        initilaize()

        // Do any additional setup after loading the view.
    }
    private func setCheckMark(for cell: UITableViewCell, location: LocationItem){
        if selectedCity == location{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
    }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: Private extension
private extension LocationViewController{
  
    func initilaize(){
        manager.fetch()
        
        title = "Select a location"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: TableViewControllerDataSource
extension LocationViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.numberOfLocationItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        let location = manager.locationItem(at: indexPath.row)
        cell.textLabel?.text = location.cityAndState
        setCheckMark(for: cell, location: location)
        
        return cell
    }
}

//MARK: TableViewControllerDelegate
extension LocationViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .checkmark
            selectedCity = manager.locationItem(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
