//
//  Event.swift
//  Que Hay
//
//  Created by Henry Fernandez on 19/08/18.
//  Copyright © 2018 Henry Fernandez. All rights reserved.
//

import Foundation

class Event {
    var title: String
    var urlImage: String
    var category: String
    var place: String
    var price: String
    var dateEvent: String
    
    init(title:String, urlImage:String, category:String, place:String, price:String, dateEvent: String){
        self.title = title
        self.urlImage = urlImage
        self.category = category
        self.place = place
        self.price = price
        self.dateEvent = dateEvent
    }
    
}
