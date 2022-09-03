//
//  LocationViewController.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 01/09/2022.
//

import UIKit

class LocationViewController: UIViewController {
   
    let manager = LocatonDataManager()
    @IBOutlet var locationTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()

        // Do any additional setup after loading the view.
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

//MARK: - private extension
extension LocationViewController{
    func initialize(){
        manager.fetch()
    }
}

//MARK: - UITableViewDataSource
extension LocationViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.numberOfLocationItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.textLabel?.text = manager.locationItem(at: indexPath.row)
        return cell
    }
    

}
