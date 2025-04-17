//
//  SinkifyMacroTests.swift
//  MyMacro
//
//  Created by Gerson Arbigaus on 16/04/25.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

import MyMacroMacros

let sinkifyMacrosTests: [String: Macro.Type] = [
    "sinkify": SinkifyMacroMacro.self,
]

final class SinkifyMacroTests: XCTestCase {
    func testMacro() throws {
        let inputSource = """
            #sinkify(self.$banana, in: trash) { banana in
                print(banana)
            }
            """

        let expected = """
            self.$banana
                .sink { [weak self] banana in
                    guard let self = self else {
                        return
                    }

                print(banana)
                }
                .store(in: &trash)
            """
        assertMacroExpansion(
            inputSource,
            expandedSource: expected,
            macros: sinkifyMacrosTests
        )
    }
}

