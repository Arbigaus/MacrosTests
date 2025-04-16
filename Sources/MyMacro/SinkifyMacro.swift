//
//  SinkifyMacro.swift
//  MyMacro
//
//  Created by Gerson Arbigaus on 16/04/25.
//
import SwiftUI
import Combine

@freestanding(expression)
public macro sinkify<Upstream: Publisher>(
    store in: inout Set<AnyCancellable>,
    _ body: @escaping (Upstream.Output) -> Void
) -> Void = #externalMacro(
    module: "MyMacroMacros",
    type: "SinkifyMacroMacro"
)
