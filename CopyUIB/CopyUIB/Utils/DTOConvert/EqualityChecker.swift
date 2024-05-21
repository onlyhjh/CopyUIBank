//
//  EqualityChecker.swift
//  IOS_CleanArchitecture_Sample
//
//  Created by 60029474 on 2022/04/28.
//

import Foundation
/**
  Struct의 Equitable 함수를 구현하기 위한 equal 함수
 */
class EqualityChecker {
	class func isEqual<LHS, RHS>(lhs: LHS, rhs: RHS) -> Bool {
		let mLhs = Mirror(reflecting: lhs).children.filter { $0.label != nil }
		let mRhs = Mirror(reflecting: rhs).children.filter { $0.label != nil }
		
		for i in 0..<mLhs.count {
			switch mLhs[i].value {
			case let valLhs as NSNumber:
				guard let valRhs = mRhs[i].value as? NSNumber, valRhs.isEqual(to: valLhs) else {
					return false
				}
			case let valLhs as Int:
				guard let valRhs = mRhs[i].value as? Int, valRhs == valLhs else {
					return false
				}
			case let valLhs as String:
				guard let valRhs = mRhs[i].value as? String, valRhs == valLhs else {
					return false
				}
			case let valLhs as Float:
				guard let valRhs = mRhs[i].value as? Float, valRhs == valLhs else {
					return false
				}
			case let valLhs as Bool:
				guard let valRhs = mRhs[i].value as? Bool, valRhs == valLhs else {
					return false
				}
				
				/* ... extend with one case for each type
				 that appear in 'SuperStruct'  */
			case _ : return false
			}
		}
		return true
	}
}
