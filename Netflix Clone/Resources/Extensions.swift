//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Olanrewaju Olakunle  on 10/11/2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter () -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
