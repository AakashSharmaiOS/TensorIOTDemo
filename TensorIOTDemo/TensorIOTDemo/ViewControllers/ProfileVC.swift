//
//  ProfileVC.swift
//  TensorIOTDemo
//
//  Created by IOSTEAM02 on 06/10/23.
//

import Foundation
import UIKit

class ProfileVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var tableView : UITableView!
    
    //Variables
    let profileViewModel = ProfileViewModel()
    var weatherData: WeatherModel?
    var nameText : String?
    var detailText : String?
    var profile : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 50
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Profile"
        self.updateUserData()
        self.getData()
    }
    
    //Functions
    func updateUserData(){
        nameLabel.text = nameText
        detailsLabel.text = detailText
        profileImage.image = profile
    }
    
    func getData() {
        profileViewModel.getWeatherDeatils(lat: "22.7196", long: "75.8577", apiKey: "61fce297c6986d1d65dce69f541125cf") { dict, error in
            if error == nil {
                self.weatherData = dict
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}

extension ProfileVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as! WeatherTableViewCell
        let dict = self.weatherData
        weatherCell.dataLabel.text = "Wind Speed: \(dict?.wind?.speed ?? 0) || Air Humidity: \(dict?.main?.humidity ?? 0)"
        return weatherCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
