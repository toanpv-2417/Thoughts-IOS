//
//  Extensions.swift
//  Thoughts
//
//  Created by pham.van.toanc on 22/07/2022.
//

import Foundation

extension String {
    func capitaizeFirstLetter() -> String {
        return self.prefix(1).uppercased() +  self.lowercased().dropFirst()
    }
}
