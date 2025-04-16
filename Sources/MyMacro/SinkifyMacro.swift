//
//  SinkifyMacro.swift
//  MyMacro
//
//  Created by Gerson Arbigaus on 16/04/25.
//
import SwiftUI
import Combine

/// A macro that produces a sink to a Publisher variable
/// For example:
///
///     #sinkify($foo, in: &fubar) { bar in
///         self.baz(item)
///     }
///
/// produces a sink to `$foo`:
///     $foo
///         .sink { [weak self] bar in
///             guard let self = self else { return }
///             self.baz(item)
///         }
///         .store(in: fubar)
///
@freestanding(expression)
public macro sinkify<Upstream: Publisher>(
    _ publisher: Upstream,
    in cancellables: inout Set<AnyCancellable>,
    _ body: @escaping (Upstream.Output) -> Void
) -> Void = #externalMacro(
    module: "MyMacroMacros",
    type: "SinkifyMacroMacro"
)
