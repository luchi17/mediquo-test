//
//  QuoteDataOut.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/01/22.
//

import Foundation


struct QuoteDataOut: Decodable {
    var quote_id: Int
    var quote: String
    var author: String
}
