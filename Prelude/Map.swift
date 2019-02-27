import Swift

// MARK: - ƒ of a

/// Pipe a value to a unary function in left-to-right order.
///
/// This is a reverse application operator providing notational convenience.
/// Its precedence is one higher than that of the backwards pipe operator `<|`
///  which allows `|>` to be nested in `<|`.
///
///      𝑥 |> ƒ₁ |> ƒ₂ |> ƒ₃
///     └───────┘     │     │
///     └─────────────┘     │
///     └───────────────────┘
///
/// The same example can be expressed through function composition possibly
/// improving expressivityby providing a visual structural separation between
/// the value and the function portions of the expression.
///
///      𝑥 |> ƒ₁ >>> ƒ₂ >>> ƒ₃
///     │    │      └─────────┘
///     │    └────────────────┘
///     └─────────────────────┘
///
/// - Note: Parameter names can be elided when using mapping operators which
/// can hurt readability and create ambiguous expressions unsolvable by the type
/// checker. In the following example, are we invoking `prefix(upTo:)`,
/// `prefix(through:)`?
///
///       let result = 4 |> "some text".prefix
///
/// Though not always possible, this can sometimes be solved by explicitly
/// naming the parameter:
///
///       let result = 4 |> "some text".prefix(upTo:) // "some"
///
/// - Parameters:
///   - a: A value to pipe.
///   - λ: A function that takes `A` and returns a transformation.
/// - Returns: The result of mapping 1`a` into `λ`.
@_transparent
internal func |> <A, B>(a: A, ƒ: (A) -> B) -> B {
    return ƒ(a)
}

/// Returns a function that will map the given value into any function passed.
///
/// - Parameter a: The value to map.
/// - Returns: A function that maps `a` into any function its passed.
@_transparent
internal func map<A, B>(_ a: A) -> (@escaping (A) -> B) -> B {
    return { ƒ in ƒ(a) }
}

/// Backwards piping operator. A variant of `|>` with its arguments flipped.
///
/// This is a right-associative infix synonym for function application with
/// lower precedence than `|>`. This is in contrast with the `•` and `()`
/// function application operators which in both cases are left-associative and
/// possess the highest possible precedence..
///
///      ƒ₃ <| ƒ₂ <| ƒ₁ <| 𝑥
///     │     │     └───────┘
///     │     └─────────────┘
///     └───────────────────┘
///
/// It can also be expressed through function composition:
///
///      ƒ₃ <<< ƒ₂ <<< ƒ₁ <| 𝑥
///     │     │     └───────┘
///     │     └─────────────┘
///     └───────────────────┘
///
/// - Note: Parameter names can be elided when using mapping operators which
/// can hurt readability and create ambiguous expressions unsolvable by the type
/// checker. In the following example, are we invoking `prefix(upTo:)`,
/// `prefix(through:)`?
///
///       let result = "some text".prefix <| 4
///
/// Though not always possible, this can sometimes be solved by explicitly
/// naming the parameter:
///
///       let result = "some text".prefix(upTo:) <| 4
///
/// - Parameters:
///   - λ: A function that takes `A` and returns a transformation.
///   - a: A value to pipe.
/// - Returns: The result of `λ` applied to `a`.
@_transparent
internal func <| <A, B>(ƒ: (A) -> B, a: A) -> B {
    return ƒ(a)
}

/// Returns a function that will apply the given function to any value passed.
///
/// The function `ap` is a redundant functional analogue to the normal function
/// application operation.
@_transparent
internal func apply<A, B>(_ ƒ: @escaping (A) -> B) -> (A) -> B {
    return ƒ
}

/// Left-associative function application operator with very high precedence..
///
/// Similar to `<|` but left-associative and with very high precedence, aiming
/// to imitate ML-like function application via juxtaposition.
///
/// Overloads for implicit partial application exist in `Partial.swift`. The
/// same considerations stated for the piping operators regarding readability
/// should be taken into accoount.
///
/// - Parameters:
///   - λ: A lambda to apply.
///   - a: A value to apply the lambda to.
/// - Returns: The result of applying the function to the given value.
@_transparent
func ^ <A, B>(ƒ: (A) -> B, a: A) -> B {
    return ƒ(a)
}

/// Returns a partially applied function with the passed value fixed to the
/// first argument of a binary function.
///
/// Left-associatively maps the argument on the right hand side to the first
/// first argument of the binary function on the right hand side and returns a
/// new function accepting the final argument which once applied will yield its
/// result.
///
/// Left-associativity enables composition without currying:
///
///     let result = ƒ • argₐ • argᵦ
///
/// Partially applied functions can be stored for later application:
///
///     let partial = ƒ • argₐ
///     let result = partial • argᵦ
///
/// - Note: Operator usage hides parameter names which can hurt readability. In
///   the following example, are we invoking `reduce(_:_:)` or `reduce(into:_:)`?
///
///       [0, 1, 2, 3].reduce • x • (+)
///
/// - Parameters:
///   - λ: A binary function to partially apply.
///   - a: A value to fix the first argument of the function to.
/// - Returns: A new function accepting the final argument which once mapped
///   will yield the result of applying the entire function.
//@_transparent
//public func ^ <A, B, C>(
//    λ: @escaping (A, B) -> C,
//    a: A
//) -> (B) -> C {
//    return { b in λ(a, b) }
//}

/// Passthrough ∎ Pipes a value forward into a function while preserving the
/// original value as the return value.
///
/// Use |>> when you need to chain effects.
///
/// - Parameters:
///   - a: A value.
///   - eff: An effectful function to take `a` which returns void.
/// - Returns: The re   sult of `f` applied to `a`.
@_transparent
internal func |>> <A, B>(a: A, eff: (A) -> B) -> A {
    return const(a)(eff(a))
}

/// Passthrough ∎ Pipes a value forward into a function while preserving the
/// original value as the return value.
///
/// Use |>> when you need to chain pure side-effects.
///
/// - Parameters:
///   - a: A value.
///   - eff: An effectful function to take `a` which returns void.
/// - Returns: The re   sult of `f` applied to `a`.
@_transparent
internal func |>> <A>(a: A, eff: (A) -> ()) -> A {
    return const(a)(eff(a))
}

/// Applies a side effect using the given value, ignores its result and returns
/// the original value.
///
/// Passthrough functions return the original value passed after evaluating.
/// This is especially useful to turn `Void` returning side-effects into
/// functions composable on instances of `𝐴`.
@_transparent
internal func tap<A>(_ eff: @escaping (A) -> ()) -> (_ a: A) -> A {
    return __ |>> eff
}

// MARK: - ƒ on g

/// Returns a function that will apply the given function into any value passed.
///
/// - Parameter λ: A function that will take the value on the second argument.
/// - Returns: The result of `λ` applied to `a`.
@_transparent
internal func map<A, B, C>(
    _ ƒ: @escaping (B) -> C)
-> (_ g: @escaping (A) -> B)
-> (A) -> C {
    return { g in ƒ ◦ g }
}

/// An infix synonym of 'map'.
///
/// The name of this operator is an allusion to '•'. Note the similarities
/// between their types:
///
/// >  (•)  ::              (a -> b) ->   a ->   b
/// > (<•>) :: Functor f => (a -> b) -> f a -> f b
///
/// Whereas '•' is function application, '<•>' is function application lifted
/// over a 'Functor'.
@_transparent
internal func <^> <A, B, C>(
    ƒ: @escaping (B) -> C,
    g: @escaping (A) -> B
) -> (A) -> C {
    return ƒ ◦ g
}

/// Returns the result of mapping a given value `𝑎` into `𝑓` and `𝑔` and then
/// mapping the result of the latter into the result of former.
///
/// [substitution]: https://en.wikipedia.org/wiki/Substitution_(algebra)
/// [applicative functor]: https://en.wikipedia.org/wiki/Applicative_functor
/// [structural]: https://en.wikipedia.org/wiki/Structural_type_system
/// [nominal]: https://en.wikipedia.org/wiki/Nominal_type_system
/// [Optional\<Wrapped\>]: https://developer.apple.com/documentation/swift/optional
/// [Optional\<Wrapped\>.map]: https://developer.apple.com/documentation/swift/optional/1539476-map
/// [Wrapped]: https://developer.apple.com/documentation/swift/optional/some
/// [(Wrapped) -> U]: https://developer.apple.com/documentation/swift/optional/1539476-map#declarations
///
/// This is the [applicative functor] operation (`apply` or `<*>`) on free
/// functions.
///
/// The operation can be visualized by way of [substitution], for example, on
/// an [Optional\<Wrapped\>] (desugared form of `Wrapped?`), `apply` would be
/// defined as:
///
///     static func apply(
///         transform: Optional<(Wrapped) -> U>,
///         to self: Optional<Wrapped>
///     ) -> Optional<U>
///
/// Where:
///  - [Wrapped] is the type of the value wrapped in the _applicative_
/// `self`,
///  - [(Wrapped) -> U] is the type of the value wrapped in the _applicative_
///    `transform` and,
///  - `?` is an operator that declares the type of _applicative functors_
///    known as [Optional\<Wrapped\>] .
///
/// _Compare the signature of apply with_ [Optional\<Wrapped\>.map].
///
/// Both `Optional<_>` `?` types can be replaced by `func` `(A) -> <_>` types,
/// where `func` is short for `function`, `(A) -> _` is the type of functions
/// from a value of some type `A` and `_` is a placeholder for an associated
/// type (like `Wrapped` is on `Optionals`):
///
///     static func apply(
///         transform: (A) -> <(Wrapped) -> U>,
///         self: (A) -> <Wrapped>
///     ) -> (A) -> <U>
///
/// Where `(Wrapped) -> U` is the type of the value wrapped in `transform`,
/// `Wrapped` is the type of the value wrapped in `self` and `U` the type
/// of the value wrapped inside the result of the operation.
///
/// - Important: In Swift, the associated type of a function type is referenced
///   without `<, >`'s:
///
///       static func apply(
///           transform: (A) -> (Wrapped) -> U,
///           to: (A) -> Wrapped
///       ) -> (A) -> U
///
/// - - -
///
/// ### Haskell definitions:
///
///     ap :: (Monad m)      => m (a -> b)      -> m a      -> m b
///        :: (Monad (->) r) => (->) r (a -> b) -> (->) r a -> (->) r b
///        :: (Monad a -> _) => (a -> b -> c)   -> (a -> b) -> (a -> c)
///     ap f g = do { a₁ <- f; a₂ <- g; return (a₁ a₂) }
///     ap f g a = f a (g a)
///
/// - Remark: The Monadic binary function `ap` on free functions is a prefix
///   variant of `<*>`. If curried, it could be expressed as:
///
///       { g in ƒ <*> g }
///
///   Or in pointfree style, more succinctly as:
///
///       (<*>) • ƒ
///
/// - Note: `•` is function application with a notation that emulates the
///   whitespace in functional languages:
///
///       (<*>) ƒ <=> (<*>) • ƒ
///
/// - Note: In combinatory logic, this function is known as the S-Combinator,
///   in λ calculus as [substitution] and it is the Starling in Raymond
///   Smullyan's To Mock a Mockingbird and related implementations of its
///   Aviary.
///
/// - Parameters:
///   - ƒ: A curried binary function.
///   - g: A unary function.
///   - a: A value to use as context.
/// - Returns: A new function accepting a value as context for application.
/// - - -
/// ¹ the algebraic process of assigning values to symbols such as the arguments
/// in a function, during application.
@_transparent
func ap<A, B, C>(
    _ ƒ: @escaping (A) -> (B) -> C)
-> (_ g: @escaping (A) -> B)
-> (A) -> C {
    return ƒ <*> __
}

/// Returns a function that will return the result of applying a curried binary
/// function `ƒ` and a unary function `g` to the given value `a` thus serving
/// as the context in which further sequential function application will be
/// promoted.
///
/// This is the Applicative Functor's binary infix operator `<*>` (aka. `apply`)
/// on free functions, as defined in Haskell notation:
///
///     instance Applicative ((->) r) where
///         (<*>) f g a = f a (g a)
///
/// - Remark: The Monadic binary function `ap` on free functions, is a curried
///   prefix synonym of this function. As such, `<*>` could be expressed as:
///
///       λap ƒ g // curry(ap)(ƒ)(g)
///
///   However, this is avoided to confer instances the ability to define `ap`
///   in terms of `<*>` and viceversa, ie. `let ap = (<*>)`.
///
/// - Note: In combinatory logic, this function is known as the S-Combinator,
///   in λ-calculus as the substitution operator, and as the starling in
///   Raymond Smullyan's To Mock a Mockingbird and related implementations of
///   its Aviary.
/// - Parameters:
///   - ƒ: A curried binary function.
///   - g: A unary function.
///   - a: A value to use as context.
/// - Returns: A new function accepting a value as context for application.
@_transparent
func <*> <A, B, C>(
    ƒ: @escaping (A) -> (B) -> C,
    g: @escaping (A) -> B
) -> (A) -> C {
    return { a in ƒ(a)(g(a)) }
}

// MARK: - ƒ on g of a

/// `on(ƒ, g)(x, y)` runs the binary function `ƒ` _on_ the results of applying
/// the unary function `g` to two same-typed arguments `a₁` and `a₂`.
///
/// Use `on` to transforms two inputs and map them into a combining function:
///
///     on(+, g) = { x, y in g(x) + g(y) }
///     on(combine, g) = { x, y in combine(g(x), g(y)) }
///
/// Use `on` to compare structures by their properties, for example:
///
///     let arr = [(2, "Second"), (1, "First"), (4, "Fourth"), (3, "Third")]
///         .sorted(by: on(<, fst)))
///     print(arr)
///     // Prints "[(1, "First"), (2, "Second"), (3, "Third"), (4, "Fourth")]"
///
/// ## Haskell definition
/// `on b u x y` runs the binary function b on the results of applying unary
/// function `u` to two arguments `x` and `y`. From the opposite perspective,
/// it transforms two inputs and combines the outputs.
///
///     on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
///     (.*.) `on` g = \x y -> g x .*. g y
///
/// In addition, `on` is defined as an infix function:
///
///     infixl 0 `on`
///
/// ### Typical usage:
///
///     ((+) `on` f) x y = f x + f y
///     sortBy (compare `on` fst).
@_transparent
func on<A, B, C>(
    _ ƒ: @escaping (B, B) -> C,
    _ g: @escaping (A) -> B
) -> (A, A) -> C {
    return { a, aꞌ in ƒ(g(a), g(aꞌ)) } // g ◦ (ƒ *** ƒ)
}

/// Description
///
/// - Parameter attribute: attribute description
/// - Returns: A binary function to apply as a sorting predicate.
func their<A, B: Comparable>(
    _ attribute: @escaping (A) -> B
) -> (A, A) -> Bool {
    return (<)′on′attribute
}


/// Description
///
/// - Parameter keyPath: keyPath description
/// - Returns: A binary function to apply as a sorting predicate.
func their<Root, Value: Comparable>(
    _ keyPath: KeyPath<Root, Value>
) -> (Root, Root) -> Bool {
    return (<)′on′get(keyPath)
}

/// Description
///
/// - Parameters:
///   - attribute: attribute description
///   - compare: A predicate that returns `true` if its first argument should be
///     ordered before its second argument; otherwise, `false`.
/// - Returns: A binary function to apply as a sorting predicate.
func their<A, B: Comparable>(
    _ attribute: @escaping (A) -> B,
    where compare: @escaping (B, B) -> Bool
) -> (A, A) -> Bool {
    return compare′on′attribute
}

/// Description
///
/// - Parameters:
///   - keyPath: keyPath description
///   - compare: A predicate that returns `true` if its first argument should be
///     ordered before its second argument; otherwise, `false`.
/// - Returns: A binary function to apply as a sorting predicate.
func their<Root, Value: Comparable>(
    _ keyPath: KeyPath<Root, Value>,
    _ compare: @escaping (Value, Value) -> Bool
) -> (Root, Root) -> Bool {
    return compare′on′get(keyPath)
}
