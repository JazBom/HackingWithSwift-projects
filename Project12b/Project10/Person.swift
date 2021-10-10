//
//  Person.swift
//  Project10
//
//  Created by Jessica Bommer on 23/9/21.
//

import UIKit

final class Person: NSObject, Codable {
    var name: String
    var image: String

    init(name: String, image: String){
        self.name = name
        self.image = image
    }
}
