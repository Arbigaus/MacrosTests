//
//  SinkifyMacroMacro.swift
//  MyMacro
//
//  Created by Gerson Arbigaus on 16/04/25.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct SinkifyMacroMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let store = node.arguments.first?.expression.description else {
            fatalError("Expected the cancellable param")
        }

        guard let closure = node.trailingClosure?.statements.first?.item,
              let param = node.trailingClosure?.signature?.parameterClause?.description else {
            fatalError("Parameter clause expected")
        }

        let generated = """
            .sink { [weak self] \(param)in
                guard let self = self else {
                    return
                }
                \(closure.description)
            }
            .store(in: \(store))
            """

        return ExprSyntax(stringLiteral: generated)
    }
}

/*
 •• •sink { [weak self]•/*Any•Argument*/•in-
 •• • guard let self else {• return }-
 •••• • • f • Any code • }-
 ••}. store(in: &cancellables)-
 */
