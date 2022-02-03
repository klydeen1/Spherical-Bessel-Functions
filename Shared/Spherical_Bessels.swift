//
//  Spherical_Bessels.swift
//  Spherical-Bessel-Functions
//
//  Created by Katelyn Lydeen on 2/2/22.
//  Based on code created by Jeff Terry on 11/30/20.
//

import Foundation
import SwiftUI

/// calculateDownwardRecursion
/// Calculates a spherical Bessel function using downward recursion
/// - Parameters:
///   - xValue: x value to evaluate the function at
///   - maxOrder: the order of the spherical Bessel function
///   - start: starting order
/// Returns an array containing ALL of the spherical Bessel functions of orders 0 through maxOrder
/// The return array may be indexed to get a specific order
//                      2l + 1
//     j      (x)  =   --------- j   (x)   -  j       (x)
//      l - 1              x       l            l + 1
func calculateDownwardRecursion(xValue: Double, order: Int, start: Int) -> Double {
    var scale = calculateFirstSphericalBessel(xValue: xValue) // Calculates JSub0 which is known
    var jSubl = Array(repeating: 0.0, count: start + 2)
    
    jSubl[start+1] = 1.0    // start with "guess"
    jSubl[start] = 1.0      // start with "guess"
    
    for index in (1...start).reversed(){
        jSubl[index-1] = ((2.0*(Double(index)) + 1)/xValue) * jSubl[index] - jSubl[index+1]
    }
    
    // Get the scale for the result
    scale = (scale)/jSubl[0];
    
    // Return the scaled result
    return(jSubl[order]*(scale))
}

/// calculateUpwardRecursion
/// Calculates a spherical Bessel function using upward recursion
/// - Parameters:
///   - xValue: x value to evaluate the function at
///   - maxOrder: the order of the spherical Bessel function
///   - start: starting order
/// Returns an array containing ALL of the spherical Bessel functions of orders 0 through maxOrder
/// The return array may be indexed to get a specific order
//                        2l + 1
//     j       (x)  =   --------- j   (x)   -  j       (x)
//      l + 1               x       l            l - 1
func calculateUpwardRecursion (xValue: Double, order: Int) -> Double {
    var jSubl = Array(repeating: 0.0, count: order + 2)
    
    jSubl[0] = calculateFirstSphericalBessel(xValue: xValue)
    jSubl[1] = calculateSecondSphericalBessel(xValue: xValue)
    
    if (order > 1) {
        for index in 1...order {
            jSubl[index+1] = ((2.0*(Double(index)) + 1)/xValue) * jSubl[index] - jSubl[index-1]
        }
    }
    
    return jSubl[order]
}

/// calculateFirstSphericalBessel
/// - Parameter xValue: x value to evaluate the function at
/// - Returns: first spherical Bessel Function
//                sin(x)
//     J  (x)  = ---------
//      0           x
func calculateFirstSphericalBessel (xValue: Double) -> Double {
    let jSub0 = sin(xValue) / xValue
    return jSub0
}

/// calculateSecondSphericalBessel
/// - Parameter xValue: x value to evaluate the function at
/// - Returns: first spherical Bessel Function
//                sin(x)
//     J  (x)  = ---------
//      0           x
func calculateSecondSphericalBessel (xValue: Double) -> Double {
    let jSub1 = (sin(xValue) / pow(xValue, 2)) - (cos(xValue) / xValue)
    return jSub1
}
