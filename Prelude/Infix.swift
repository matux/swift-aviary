import Swift

// MARK: - Moniker

/// `Moniker` is a cheap trivial variant of a `Tagged` type, more
/// specifically, it is like a stolen `Tagged` that was scrapped and
/// sold for parts. Kind of like a `newtype`, but worse. Or an opaque
/// type that you can fully see through... Or `typealias` that is very
/// inconvenient to use somehow... This is, `Moniker`.
///
/// Any type can be decorated with a `Moniker`, nominal or structural
/// (functions and tuples). Yes, `Moniker` believes in equal opportunity.
/// It is cheap, and it will let you do anything you want to i—with it.
///
/// More seriously, a `Moniker` typifies its raw type by bounding them
/// to a scary type called a "phantom type". Phantom types draw their
/// powers from the carcasses of dead code allowing you to decorate
/// values with raw primitive types like `email: String` with a new type
/// that can be called Email, and that the compiler will type check
/// if instead of a value of type Email, you try to shove something in
/// it other than that, like a number, or a picture or a shoe.
///
/// Not too shabby, eh?
public struct Moniker<Phantom, Canonical> {
    var canonical: Canonical

    init(_ value: Canonical) {
        canonical = value
    }
}

// MARK: - Infix functions

/// Provides a type-safe syntactic mechanism to emulate infix functions ad-hoc.
///
/// These functions could now be called using the following syntax:
///
///     lens′over′user
///     arr.sort(by: greaterThan′on′evenNumber)
///
/// ### How it works
/// Partially applies a given binary function `ƒ` to `a` returning a new
/// _tagged_ function on `b` which will return the final result of `ƒ` upon
/// application.
///
/// `(′)` implicitly curries the given function in order to fix its first
/// parameter without the need to provide its second one. The operation itself
/// is redundant and there are more idiomatic ways of achieving this effect.
///
/// ### Detailed explanation
/// However, by endowing `(′)` with the ability to partially apply binary
/// functions, it provides a _very_ lightweight ad-hoc mechanism for infix
/// functions generic over _any_ type. A feature not available in Swift that's
/// typical of Functional languages. This could be particularly useful when
/// applying commutative higher-order functions, since their semantics dictate
/// symmetry over their parameters and are named after prepositions, eg. _by_,
/// _of_, _over_, _on_, _at_, _after_, _until_, etc.
///
/// - Parameters:
///   - a: An instance of `A` to be fixed for `ƒ`
///   - ƒ: A binary function to apply partially.
/// - Returns: A `PartiallyAppliedInfix` for the right-hand side infix
///   function operator `′` to handle.
@_transparent
internal func ′ <A, B, C>(
    a: A,
    f: (A, B) -> C
) -> PartiallyAppliedInfix<(B) -> C> {
    return nonescaping(f) { f in .init(curry(f)(a)) }
}

/// Applies the right-hand side argument of the given `PartiallyAppliedInfix`
/// to a value of the expected type.
@_transparent
internal func ′ <B, C>(partialInfix: PartiallyAppliedInfix<(B) -> C>, b: B) -> C {
    return partialInfix.canonical(b)
}

internal typealias PartiallyAppliedInfix<F> = Moniker<Tag.PartiallyAppliedInfix, F>

// MARK: - 2-ary infixed partial

///
@_transparent
internal func partial<A, B, C>(
    _ a: (A),
    _ λ: @escaping (A, B) -> C,
    _  : (·)
) -> (B) -> C {
    return { b in λ(a, b) }
}

///
@_transparent
internal func partial<A, B, C>(
    _  : (·),
    _ λ: @escaping (A, B) -> C,
    _ b: (B)
) -> (A) -> C {
    return { a in λ(a, b) }
}


// MARK: - ◦

/// Partially applies _either_ the left-hand side _or_ the right-hand
/// side section of a (◦) binary operation.
///
/// Partial application occurs by fixing the given value in the returned
/// function. The returned function will accept the value for the
/// remaining section as required by (◦) to be fully applied and
/// return its proper result.
///
///     let partial = __ ◦ innerFunc
///
/// - Parameters
///   - lhs: A value that the left-hand side section of (◦)
///     will accept or `__`.
///   - rhs: A value that the right-hand side section of (◦)
///     will accept or `__`.
/// - Returns: A function accepting the remaining side of (◦)
///   that will in turn, return the result of fully applying (◦).
@_transparent
internal func ◦ <A, B, C>(
    _ lhs: @escaping (B) -> C,
    _    : ·)
-> (_ rhs: @escaping (A) -> B)
-> (_ a: A) -> C {
    return partial(lhs, ◦, __)
}

/// Partially applies a section of a (◦) binary operation.
///
/// Fixes the given value by returning a new function accepting the
/// remaining value required by (◦) that will fully apply (◦)
/// once it is provided.
///
///     let partial = outerFunc ◦ __
///
/// - Parameter lhs: A value that the left-hand side section of (◦)
///   will accept.
/// - Returns: A function accepting the right-hand side of (◦)
///   that will return the result of fully applying (◦) once
@_transparent
internal func ◦ <A, B, C>(
    _    : ·,
    _ rhs: @escaping (A) -> B)
-> (_ lhs: @escaping (B) -> C)
-> (_ a: A) -> C {
    return partial(__, ◦, rhs)
}

// MARK: - ^

/// Partially applies _either_ the left-hand side _or_ the right-hand
/// side section of a (^) binary operation.
///
/// Partial application occurs by fixing the given value in the returned
/// function. The returned function will accept the value for the
/// remaining section as required by (^) to be fully applied and
/// return its proper result.
///
///     let partial = __ ^ someValue
///
/// - Parameters
///   - lhs: A value that the left-hand side section of (^)
///     will accept or `__`.
///   - rhs: A value that the right-hand side section of (^)
///     will accept or `__`.
/// - Returns: A function accepting the remaining side of (^)
///   that will in turn, return the result of fully applying (^).
@_transparent
internal func ^ <T, Result>(
    _ lhs: @escaping (T) -> Result,
    _    : ·)
-> (_ rhs: T)
-> Result {
    return partial(lhs, ^, __)
}

/// Partially applies a section of a (^) binary operation.
///
/// Fixes the given value by returning a new function accepting the
/// remaining value required by (^) that will fully apply (^)
/// once it is provided.
///
///     let partial = someFunc ^ __
///
/// - Parameter lhs: A value that the left-hand side section of (^)
///   will accept.
/// - Returns: A function accepting the right-hand side of (^)
///   that will return the result of fully applying (^) once
@_transparent
internal func ^ <T, Result>(
    _    : ·,
    _ rhs: T)
-> (_ lhs: @escaping (T) -> Result)
-> Result {
    return partial(__, ^, rhs)
}

// MARK: - ==

/// Partially applies _either_ the left-hand side _or_ the right-hand
/// side section of a (==) binary operation.
///
/// Partial application occurs by fixing the given value in the returned
/// function. The returned function will accept the value for the
/// remaining section as required by (==) to be fully applied and
/// return its proper result.
///
///     let partial = __ == 1
///
/// - Parameters
///   - lhs: A value that the left-hand side section of (==)
///     will accept or `__`.
///   - rhs: A value that the right-hand side section of (==)
///     will accept or `__`.
/// - Returns: A function accepting the remaining side of (==)
///   that will in turn, return the result of fully applying (==).
@_transparent
internal func == <T: Equatable>(
    _ lhs: T,
    _    : ·)
-> (_ rhs: T)
-> Bool {
    return partial(lhs, ==, __)
}

/// Partially applies a section of a (==) binary operation.
///
/// Fixes the given value by returning a new function accepting the
/// remaining value required by (==) that will fully apply (==)
/// once it is provided.
///
///     let partial = integer == __
///
/// - Parameter lhs: A value that the left-hand side section of (==)
///   will accept.
/// - Returns: A function accepting the right-hand side of (==)
///   that will return the result of fully applying (==) once
@_transparent
internal func == <T: Equatable>(
    _    : ·,
    _ rhs: T)
-> (_ lhs: T)
-> Bool {
    return partial(__, ==, rhs)
}

// MARK: - !=

/// Partially applies _either_ the left-hand side _or_ the right-hand
/// side section of a (!=) binary operation.
///
/// Partial application occurs by fixing the given value in the returned
/// function. The returned function will accept the value for the
/// remaining section as required by (!=) to be fully applied and
/// return its proper result.
///
///     let partial = __ != nil
///
/// - Parameters
///   - lhs: A value that the left-hand side section of (!=)
///     will accept or `__`.
///   - rhs: A value that the right-hand side section of (!=)
///     will accept or `__`.
/// - Returns: A function accepting the remaining side of (!=)
///   that will in turn, return the result of fully applying (!=).
@_transparent
internal func != <T: Equatable>(
    _ lhs: T,
    _    : ·)
-> (_ rhs: T)
-> Bool {
    return partial(lhs, !=, __)
}

/// Partially applies a section of a (!=) binary operation.
///
/// Fixes the given value by returning a new function accepting the
/// remaining value required by (!=) that will fully apply (!=)
/// once it is provided.
///
///     let partial = optional != __
///
/// - Parameter lhs: A value that the left-hand side section of (!=)
///   will accept.
/// - Returns: A function accepting the right-hand side of (!=)
///   that will return the result of fully applying (!=) once
@_transparent
internal func != <T: Equatable>(
    _    : ·,
    _ rhs: T)
-> (_ lhs: T)
-> Bool {
    return partial(__, !=, rhs)
}

// MARK: - <<<

/// Partially applies _either_ the left-hand side _or_ the right-hand
/// side section of a (<<<) binary operation.
///
/// Partial application occurs by fixing the given value in the returned
/// function. The returned function will accept the value for the
/// remaining section as required by (<<<) to be fully applied and
/// return its proper result.
///
///     let partial = __ <<< innerFunc
///
/// - Parameters
///   - lhs: A value that the left-hand side section of (<<<)
///     will accept or `__`.
///   - rhs: A value that the right-hand side section of (<<<)
///     will accept or `__`.
/// - Returns: A function accepting the remaining side of (<<<)
///   that will in turn, return the result of fully applying (<<<).
@_transparent
internal func <<< <A, B, C>(
    _ lhs: @escaping (B) -> C,
    _    : ·)
-> (_ rhs: @escaping (A) -> B)
-> (_ a: A) -> C {
    return partial(lhs, <<<, __)
}

/// Partially applies a section of a (<<<) binary operation.
///
/// Fixes the given value by returning a new function accepting the
/// remaining value required by (<<<) that will fully apply (<<<)
/// once it is provided.
///
///     let partial = outerFunc <<< __
///
/// - Parameter lhs: A value that the left-hand side section of (<<<)
///   will accept.
/// - Returns: A function accepting the right-hand side of (<<<)
///   that will return the result of fully applying (<<<) once
@_transparent
internal func <<< <A, B, C>(
    _    : ·,
    _ rhs: @escaping (A) -> B)
-> (_ lhs: @escaping (B) -> C)
-> (_ a: A) -> C {
    return partial(__, <<<, rhs)
}

// MARK: - >>>

/// Partially applies _either_ the left-hand side _or_ the right-hand
/// side section of a (>>>) binary operation.
///
/// Partial application occurs by fixing the given value in the returned
/// function. The returned function will accept the value for the
/// remaining section as required by (>>>) to be fully applied and
/// return its proper result.
///
///     let partial = __ >>> outerFunc
///
/// - Parameters
///   - lhs: A value that the left-hand side section of (>>>)
///     will accept or `__`.
///   - rhs: A value that the right-hand side section of (>>>)
///     will accept or `__`.
/// - Returns: A function accepting the remaining side of (>>>)
///   that will in turn, return the result of fully applying (>>>).
@_transparent
internal func >>> <A, B, C>(
    _ lhs: @escaping (A) -> B,
    _    : ·)
-> (_ rhs: @escaping (B) -> C)
-> (_ a: A) -> C {
    return partial(lhs, >>>, __)
}

/// Partially applies a section of a (>>>) binary operation.
///
/// Fixes the given value by returning a new function accepting the
/// remaining value required by (>>>) that will fully apply (>>>)
/// once it is provided.
///
///     let partial = innerFunc >>> __
///
/// - Parameter lhs: A value that the left-hand side section of (>>>)
///   will accept.
/// - Returns: A function accepting the right-hand side of (>>>)
///   that will return the result of fully applying (>>>) once
@_transparent
internal func >>> <A, B, C>(
    _    : ·,
    _ rhs: @escaping (B) -> C)
-> (_ lhs: @escaping (A) -> B)
-> (_ a: A) -> C {
    return partial(__, >>>, rhs)
}

// MARK: - |>>

/// Partially applies _either_ the left-hand side _or_ the right-hand
/// side section of a (|>>) binary operation.
///
/// Partial application occurs by fixing the given value in the returned
/// function. The returned function will accept the value for the
/// remaining section as required by (|>>) to be fully applied and
/// return its proper result.
///
///     let partial = __ |>> effect
///
/// - Parameters
///   - lhs: A value that the left-hand side section of (|>>)
///     will accept or `__`.
///   - rhs: A value that the right-hand side section of (|>>)
///     will accept or `__`.
/// - Returns: A function accepting the remaining side of (|>>)
///   that will in turn, return the result of fully applying (|>>).
@_transparent
internal func |>> <T, Result>(
    _ lhs: T,
    _    : ·)
-> (_ rhs: @escaping (T) -> Result)
-> T {
    return partial(lhs, |>>, __)
}

/// Partially applies a section of a (|>>) binary operation.
///
/// Fixes the given value by returning a new function accepting the
/// remaining value required by (|>>) that will fully apply (|>>)
/// once it is provided.
///
///     let partial = value |>> __
///
/// - Parameter lhs: A value that the left-hand side section of (|>>)
///   will accept.
/// - Returns: A function accepting the right-hand side of (|>>)
///   that will return the result of fully applying (|>>) once
@_transparent
internal func |>> <T, Result>(
    _    : ·,
    _ rhs: @escaping (T) -> Result)
-> (_ lhs: T)
-> T {
    return partial(__, |>>, rhs)
}

// MARK: - |>>

/// Partially applies _either_ the left-hand side _or_ the right-hand
/// side section of a (|>>) binary operation.
///
/// Partial application occurs by fixing the given value in the returned
/// function. The returned function will accept the value for the
/// remaining section as required by (|>>) to be fully applied and
/// return its proper result.
///
///     let partial = __ |>> effect
///
/// - Parameters
///   - lhs: A value that the left-hand side section of (|>>)
///     will accept or `__`.
///   - rhs: A value that the right-hand side section of (|>>)
///     will accept or `__`.
/// - Returns: A function accepting the remaining side of (|>>)
///   that will in turn, return the result of fully applying (|>>).
@_transparent
internal func |>> <T>(
    _ lhs: T,
    _    : ·)
-> (_ rhs: @escaping (T) -> ())
-> T {
    return partial(lhs, |>>, __)
}

/// Partially applies a section of a (|>>) binary operation.
///
/// Fixes the given value by returning a new function accepting the
/// remaining value required by (|>>) that will fully apply (|>>)
/// once it is provided.
///
///     let partial = value |>> __
///
/// - Parameter lhs: A value that the left-hand side section of (|>>)
///   will accept.
/// - Returns: A function accepting the right-hand side of (|>>)
///   that will return the result of fully applying (|>>) once
@_transparent
internal func |>> <T>(
    _    : ·,
    _ rhs: @escaping (T) -> ())
-> (_ lhs: T)
-> T {
    return partial(__, |>>, rhs)
}

// MARK: - <*>

/// Partially applies _either_ the left-hand side _or_ the right-hand
/// side section of a (<*>) binary operation.
///
/// Partial application occurs by fixing the given value in the returned
/// function. The returned function will accept the value for the
/// remaining section as required by (<*>) to be fully applied and
/// return its proper result.
///
///     let partial = __ <*> someFunc
///
/// - Parameters
///   - lhs: A value that the left-hand side section of (<*>)
///     will accept or `__`.
///   - rhs: A value that the right-hand side section of (<*>)
///     will accept or `__`.
/// - Returns: A function accepting the remaining side of (<*>)
///   that will in turn, return the result of fully applying (<*>).
@_transparent
internal func <*> <A, B, C>(
    _ lhs: @escaping (A) -> (B) -> C,
    _    : ·)
-> (_ rhs: @escaping (A) -> B)
-> (A) -> C {
    return partial(lhs, <*>, __)
}

/// Partially applies a section of a (<*>) binary operation.
///
/// Fixes the given value by returning a new function accepting the
/// remaining value required by (<*>) that will fully apply (<*>)
/// once it is provided.
///
///     let partial = nestedFunc <*> __
///
/// - Parameter lhs: A value that the left-hand side section of (<*>)
///   will accept.
/// - Returns: A function accepting the right-hand side of (<*>)
///   that will return the result of fully applying (<*>) once
@_transparent
internal func <*> <A, B, C>(
    _    : ·,
    _ rhs: @escaping (A) -> B)
-> (_ lhs: @escaping (A) -> (B) -> C)
-> (A) -> C {
    return partial(__, <*>, rhs)
}
