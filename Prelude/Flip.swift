// -*- generated file, do not modify directly -*-
import Swift

// MARK: - Flip

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take its arguments in the reverse order of `λ` as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello", "world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, Result>(
  _ λ: @escaping (A, B) -> Result
) -> (B, A) -> Result {
    return { b, a in λ(a, b) }
}

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take its arguments in the reverse order of `λ` as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello", "world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, C, Result>(
  _ λ: @escaping (A, B, C) -> Result
) -> (C, B, A) -> Result {
    return { c, b, a in λ(a, b, c) }
}

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take its arguments in the reverse order of `λ` as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello", "world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, C, D, Result>(
  _ λ: @escaping (A, B, C, D) -> Result
) -> (D, C, B, A) -> Result {
    return { d, c, b, a in λ(a, b, c, d) }
}

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take its arguments in the reverse order of `λ` as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello", "world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, C, D, E, Result>(
  _ λ: @escaping (A, B, C, D, E) -> Result
) -> (E, D, C, B, A) -> Result {
    return { e, d, c, b, a in λ(a, b, c, d, e) }
}

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take its arguments in the reverse order of `λ` as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello", "world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, C, D, E, F, Result>(
  _ λ: @escaping (A, B, C, D, E, F) -> Result
) -> (F, E, D, C, B, A) -> Result {
    return { f, e, d, c, b, a in λ(a, b, c, d, e, f) }
}

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take its arguments in the reverse order of `λ` as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello", "world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, C, D, E, F, G, Result>(
  _ λ: @escaping (A, B, C, D, E, F, G) -> Result
) -> (G, F, E, D, C, B, A) -> Result {
    return { g, f, e, d, c, b, a in λ(a, b, c, d, e, f, g) }
}

// MARK: - Flipping curries

/// Returns a curried invocation of a similarly curried function `λ`
/// but that takes its arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, Result>(
    _ λ: @escaping (A) -> (B) -> Result
) -> (B) -> (A) -> Result {
    return { b in { a in 
        λ(a)(b)
     } }
}

/// Returns a curried invocation of a similarly curried function `λ`
/// but that takes its arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, C, Result>(
    _ λ: @escaping (A) -> (B) -> (C) -> Result
) -> (C) -> (B) -> (A) -> Result {
    return { c in { b in { a in 
        λ(a)(b)(c)
     } } }
}

/// Returns a curried invocation of a similarly curried function `λ`
/// but that takes its arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, C, D, Result>(
    _ λ: @escaping (A) -> (B) -> (C) -> (D) -> Result
) -> (D) -> (C) -> (B) -> (A) -> Result {
    return { d in { c in { b in { a in 
        λ(a)(b)(c)(d)
     } } } }
}

/// Returns a curried invocation of a similarly curried function `λ`
/// but that takes its arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, C, D, E, Result>(
    _ λ: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> Result
) -> (E) -> (D) -> (C) -> (B) -> (A) -> Result {
    return { e in { d in { c in { b in { a in 
        λ(a)(b)(c)(d)(e)
     } } } } }
}

/// Returns a curried invocation of a similarly curried function `λ`
/// but that takes its arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, C, D, E, F, Result>(
    _ λ: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> Result
) -> (F) -> (E) -> (D) -> (C) -> (B) -> (A) -> Result {
    return { f in { e in { d in { c in { b in { a in 
        λ(a)(b)(c)(d)(e)(f)
     } } } } } }
}

/// Returns a curried invocation of a similarly curried function `λ`
/// but that takes its arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
@inlinable
internal func flip<A, B, C, D, E, F, G, Result>(
    _ λ: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> Result
) -> (G) -> (F) -> (E) -> (D) -> (C) -> (B) -> (A) -> Result {
    return { g in { f in { e in { d in { c in { b in { a in 
        λ(a)(b)(c)(d)(e)(f)(g)
     } } } } } } }
}

// MARK: - Flipping instance methods

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Remark: This variant addresses an [issue](issue) in Swift when
///   invoking instance methods statically. This variant should be
///   [temporary](temp) although the [timeline](time) seems uncertain.
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
/// [issue]: https://bugs.swift.org/browse/SR-1051
/// [temp]: https://github.com/apple/swift-evolution/blob/master/proposals/0042-flatten-method-types.md
/// [time]: https://github.com/apple/swift/pull/3836
@inlinable
internal func flip<Self, A, B, Result>(
    _ λ: @escaping (Self) -> (A, B) -> Result
) -> (B, A) -> (Self) -> Result {
    return { b, a in { `self` in λ(`self`)(a, b) } }
}

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Remark: This variant addresses an [issue](issue) in Swift when
///   invoking instance methods statically. This variant should be
///   [temporary](temp) although the [timeline](time) seems uncertain.
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
/// [issue]: https://bugs.swift.org/browse/SR-1051
/// [temp]: https://github.com/apple/swift-evolution/blob/master/proposals/0042-flatten-method-types.md
/// [time]: https://github.com/apple/swift/pull/3836
@inlinable
internal func flip<Self, A, B, C, Result>(
    _ λ: @escaping (Self) -> (A, B, C) -> Result
) -> (C, B, A) -> (Self) -> Result {
    return { c, b, a in { `self` in λ(`self`)(a, b, c) } }
}

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Remark: This variant addresses an [issue](issue) in Swift when
///   invoking instance methods statically. This variant should be
///   [temporary](temp) although the [timeline](time) seems uncertain.
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
/// [issue]: https://bugs.swift.org/browse/SR-1051
/// [temp]: https://github.com/apple/swift-evolution/blob/master/proposals/0042-flatten-method-types.md
/// [time]: https://github.com/apple/swift/pull/3836
@inlinable
internal func flip<Self, A, B, C, D, Result>(
    _ λ: @escaping (Self) -> (A, B, C, D) -> Result
) -> (D, C, B, A) -> (Self) -> Result {
    return { d, c, b, a in { `self` in λ(`self`)(a, b, c, d) } }
}

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Remark: This variant addresses an [issue](issue) in Swift when
///   invoking instance methods statically. This variant should be
///   [temporary](temp) although the [timeline](time) seems uncertain.
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
/// [issue]: https://bugs.swift.org/browse/SR-1051
/// [temp]: https://github.com/apple/swift-evolution/blob/master/proposals/0042-flatten-method-types.md
/// [time]: https://github.com/apple/swift/pull/3836
@inlinable
internal func flip<Self, A, B, C, D, E, Result>(
    _ λ: @escaping (Self) -> (A, B, C, D, E) -> Result
) -> (E, D, C, B, A) -> (Self) -> Result {
    return { e, d, c, b, a in { `self` in λ(`self`)(a, b, c, d, e) } }
}

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Remark: This variant addresses an [issue](issue) in Swift when
///   invoking instance methods statically. This variant should be
///   [temporary](temp) although the [timeline](time) seems uncertain.
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
/// [issue]: https://bugs.swift.org/browse/SR-1051
/// [temp]: https://github.com/apple/swift-evolution/blob/master/proposals/0042-flatten-method-types.md
/// [time]: https://github.com/apple/swift/pull/3836
@inlinable
internal func flip<Self, A, B, C, D, E, F, Result>(
    _ λ: @escaping (Self) -> (A, B, C, D, E, F) -> Result
) -> (F, E, D, C, B, A) -> (Self) -> Result {
    return { f, e, d, c, b, a in { `self` in λ(`self`)(a, b, c, d, e, f) } }
}

/// Returns an n-ary function that calls the given function passing its
/// arguments in reverse order.
///
/// `flip(λ)` will take the arguments of `λ` in their reverse order as
/// denoted by `flip(λ)(y, x) ⟹ λ(x, y)`:
///
///       4> flip(+)("hello")("world")
///     $R0: String = "worldhello"
///
/// - Remark: This variant addresses an [issue](issue) in Swift when
///   invoking instance methods statically. This variant should be
///   [temporary](temp) although the [timeline](time) seems uncertain.
///
/// - Parameter λ: An n-ary function.
/// - Returns: An n-ary function that takes the same arguments as the
///   given function but in reverse order.
/// [issue]: https://bugs.swift.org/browse/SR-1051
/// [temp]: https://github.com/apple/swift-evolution/blob/master/proposals/0042-flatten-method-types.md
/// [time]: https://github.com/apple/swift/pull/3836
@inlinable
internal func flip<Self, A, B, C, D, E, F, G, Result>(
    _ λ: @escaping (Self) -> (A, B, C, D, E, F, G) -> Result
) -> (G, F, E, D, C, B, A) -> (Self) -> Result {
    return { g, f, e, d, c, b, a in { `self` in λ(`self`)(a, b, c, d, e, f, g) } }
}

