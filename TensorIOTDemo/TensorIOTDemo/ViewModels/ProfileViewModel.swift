//
//  ProfileViewModel.swift
//  TensorIOTDemo
//
//  Created by IOSTEAM02 on 06/10/23.
//

import Foundation

struct ProfileViewModel {
    
    func getWeatherDeatils(lat:String,long:String,apiKey:String, completion:@escaping (WeatherModel?,NSError?) -> ()) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(apiKey)"
        guard let serviceUrl = URL(string: url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(WeatherModel.self, from: data)
                    completion(json,nil)
                } catch {
                    print(error)
                    completion(nil,error as NSError)
                }
            }
        }.resume()
    }
    
}
