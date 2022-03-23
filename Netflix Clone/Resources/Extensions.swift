//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Aleksa Stojiljkovic on 19.3.22..
//

import Foundation


extension String {
    func capitalizeFirstletter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
