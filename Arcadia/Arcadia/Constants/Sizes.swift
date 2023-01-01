//
//  Sizes.swift
//  Arcadia
//
//  Created by Евгений Киреичев on 02.07.2022.
//

import UIKit

enum Sizes {
    enum Court {
        static var width: CGFloat { 400 }
        static var height: CGFloat { 800 }
    }
    
    enum Ball {
        static var radius: CGFloat { 4 }
    }
    
    enum Slider {
        enum Rectangle {
            static var width: CGFloat { 80 }
            static var height: CGFloat { 20 }
        }
        
        enum Circle {
            static var radius: CGFloat { 16 }
        }
    }
    
    enum Goal {
        static var width: CGFloat { 120 }
        static var height: CGFloat { 8 }
    }
    
    enum Brick {
        static var width: CGFloat { 40 }
        static var height: CGFloat { 20 }
    }
}
