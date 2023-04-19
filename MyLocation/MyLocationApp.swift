//
//  MyLocationApp.swift
//  MyLocation
//
//  Created by ctocto on 2023/4/17.
//

import SwiftUI

@main
struct MyLocationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(LocationManager())
        }
    }
}
