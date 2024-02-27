//
//  Device.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 27/02/2024.
//
import UIKit
import Foundation

enum Device{
    static var isPad: Bool{
        UIDevice.current.userInterfaceIdiom == .pad
    }
    static var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
