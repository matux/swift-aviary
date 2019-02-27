import Swift

// MARK: - curry

/// Decorates a function with multiple parameters with a sequence of
/// functions, each with a single argument, deferring the call to the
/// original function until the last argument is provided.
///
/// - Parameter λ: An n-ary function of two or more parameters.
/// - Returns: A sequence of unary functions accepting `λ`'s arguments
///   one call at a time.
@inlinable
internal func curry<A, B, Result>(
  _ λ: @escaping (A, B) -> Result
) -> (A) -> (B) -> Result {
    return { a in { b in 
        λ(a, b)
     } }
}

// MARK: - curry

/// Decorates a function with multiple parameters with a sequence of
/// functions, each with a single argument, deferring the call to the
/// original function until the last argument is provided.
///
/// - Parameter λ: An n-ary function of two or more parameters.
/// - Returns: A sequence of unary functions accepting `λ`'s arguments
///   one call at a time.
@inlinable
internal func curry<A, B, C, Result>(
  _ λ: @escaping (A, B, C) -> Result
) -> (A) -> (B) -> (C) -> Result {
    return { a in { b in { c in 
        λ(a, b, c)
     } } }
}

// MARK: - curry

/// Decorates a function with multiple parameters with a sequence of
/// functions, each with a single argument, deferring the call to the
/// original function until the last argument is provided.
///
/// - Parameter λ: An n-ary function of two or more parameters.
/// - Returns: A sequence of unary functions accepting `λ`'s arguments
///   one call at a time.
@inlinable
internal func curry<A, B, C, D, Result>(
  _ λ: @escaping (A, B, C, D) -> Result
) -> (A) -> (B) -> (C) -> (D) -> Result {
    return { a in { b in { c in { d in 
        λ(a, b, c, d)
     } } } }
}

// MARK: - curry

/// Decorates a function with multiple parameters with a sequence of
/// functions, each with a single argument, deferring the call to the
/// original function until the last argument is provided.
///
/// - Parameter λ: An n-ary function of two or more parameters.
/// - Returns: A sequence of unary functions accepting `λ`'s arguments
///   one call at a time.
@inlinable
internal func curry<A, B, C, D, E, Result>(
  _ λ: @escaping (A, B, C, D, E) -> Result
) -> (A) -> (B) -> (C) -> (D) -> (E) -> Result {
    return { a in { b in { c in { d in { e in 
        λ(a, b, c, d, e)
     } } } } }
}

// MARK: - curry

/// Decorates a function with multiple parameters with a sequence of
/// functions, each with a single argument, deferring the call to the
/// original function until the last argument is provided.
///
/// - Parameter λ: An n-ary function of two or more parameters.
/// - Returns: A sequence of unary functions accepting `λ`'s arguments
///   one call at a time.
@inlinable
internal func curry<A, B, C, D, E, F, Result>(
  _ λ: @escaping (A, B, C, D, E, F) -> Result
) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> Result {
    return { a in { b in { c in { d in { e in { f in 
        λ(a, b, c, d, e, f)
     } } } } } }
}

// MARK: - curry

/// Decorates a function with multiple parameters with a sequence of
/// functions, each with a single argument, deferring the call to the
/// original function until the last argument is provided.
///
/// - Parameter λ: An n-ary function of two or more parameters.
/// - Returns: A sequence of unary functions accepting `λ`'s arguments
///   one call at a time.
@inlinable
internal func curry<A, B, C, D, E, F, G, Result>(
  _ λ: @escaping (A, B, C, D, E, F, G) -> Result
) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> Result {
    return { a in { b in { c in { d in { e in { f in { g in 
        λ(a, b, c, d, e, f, g)
     } } } } } } }
}

// MARK: - uncurry

/// Decorates a sequence of unary functions with a function that will
/// take all of the parameters in a single call.
///
/// - Parameter λ: A sequence of unary function (ie. an uncurried
///   function).
/// - Returns: A function that takes all the sequential functions'
///   parameters with a single call.
@inlinable
internal func uncurry<A, B, Result>(
  _ λ: @escaping (A) -> (B) -> Result
) -> (A, B) -> Result {
    return { a, b in λ(a)(b) }
}

/// Decorates a sequence of unary functions with a function that will
/// take all of the parameters in a single call.
///
/// - Parameter λ: A sequence of unary function (ie. an uncurried
///   function).
/// - Returns: A function that takes all the sequential functions'
///   parameters with a single call.
@inlinable
internal func uncurry<A, B, C, Result>(
  _ λ: @escaping (A) -> (B) -> (C) -> Result
) -> (A, B, C) -> Result {
    return { a, b, c in λ(a)(b)(c) }
}

/// Decorates a sequence of unary functions with a function that will
/// take all of the parameters in a single call.
///
/// - Parameter λ: A sequence of unary function (ie. an uncurried
///   function).
/// - Returns: A function that takes all the sequential functions'
///   parameters with a single call.
@inlinable
internal func uncurry<A, B, C, D, Result>(
  _ λ: @escaping (A) -> (B) -> (C) -> (D) -> Result
) -> (A, B, C, D) -> Result {
    return { a, b, c, d in λ(a)(b)(c)(d) }
}

/// Decorates a sequence of unary functions with a function that will
/// take all of the parameters in a single call.
///
/// - Parameter λ: A sequence of unary function (ie. an uncurried
///   function).
/// - Returns: A function that takes all the sequential functions'
///   parameters with a single call.
@inlinable
internal func uncurry<A, B, C, D, E, Result>(
  _ λ: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> Result
) -> (A, B, C, D, E) -> Result {
    return { a, b, c, d, e in λ(a)(b)(c)(d)(e) }
}

/// Decorates a sequence of unary functions with a function that will
/// take all of the parameters in a single call.
///
/// - Parameter λ: A sequence of unary function (ie. an uncurried
///   function).
/// - Returns: A function that takes all the sequential functions'
///   parameters with a single call.
@inlinable
internal func uncurry<A, B, C, D, E, F, Result>(
  _ λ: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> Result
) -> (A, B, C, D, E, F) -> Result {
    return { a, b, c, d, e, f in λ(a)(b)(c)(d)(e)(f) }
}

/// Decorates a sequence of unary functions with a function that will
/// take all of the parameters in a single call.
///
/// - Parameter λ: A sequence of unary function (ie. an uncurried
///   function).
/// - Returns: A function that takes all the sequential functions'
///   parameters with a single call.
@inlinable
internal func uncurry<A, B, C, D, E, F, G, Result>(
  _ λ: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> Result
) -> (A, B, C, D, E, F, G) -> Result {
    return { a, b, c, d, e, f, g in λ(a)(b)(c)(d)(e)(f)(g) }
}
