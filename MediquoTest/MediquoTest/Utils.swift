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

}
