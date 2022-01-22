//
//  Utils.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/01/22.
//

import UIKit

class Utils {
    
    static func getImage(from string: String) -> UIImage? {
        guard let url = URL(string: string) else {
             return nil
        }

        var image: UIImage?
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        return image
    }
    
    static func getAgeFromBirthDate(dateString: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        guard let myDate = dateFormatter.date(from: dateString) else { return "Unknown" }

        let age: Int = Calendar.current.dateComponents([.year], from: myDate, to: Date()).year ?? 0
        
        return String(age)
    }

}
