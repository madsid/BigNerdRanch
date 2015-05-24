//
//  main.swift
//  RandomItems
//
//  Created by sid on 5/21/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import Foundation

var items = [BNRItem]()

for(var i=0; i < 10; i++ ){
    var item = BNRItem().randomItem()
    items.append(item)
}

for item in items {
    println(item)
}

var container = BNRContainer()
container.containerName = "BNRContainer 1"

for(var i=0; i < 10; i++ ){
    var item = BNRItem().randomItem()
    container.addItem(item)
}

println(container)

for item in container.getItems() {
    println(item)
}

