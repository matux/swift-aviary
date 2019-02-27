import Swift

/// *** Caveat Emptor!
///     You're about to subject your eyes to extremely non-
///     idiomatic Swift code. Not for the faint of heart.
///     This code is guaranteed to offend the sensibilities
///     of anyone deemed possessor of dignity, of which the
///     author has none. ***

//           ι
// Minimal:  S,K
// Curry:    S,K,I
// Extended: S,K,I,Y,B,C
// Turner:   S,K,I,Y,B,C,B',C',S'

extension λ {

    /// The theory of combinators is an abstract science dealing with objects
    /// whose only important property is how they act upon each other.
    ///
    /// # Concerning λ (lambda).
    ///
    /// Relax, it's just y turned upside-down.
    ///
    /// - - -
    ///
    /// Haskell equivalent declarations and implementations included mainly due to
    /// Swift's code being too beautiful and self-documenting: I needed something
    /// horrible and very hard to read to balance it. Thank you, Haskell.
    ///
    /// The horrible incomprehensible Haskell version is exemplified below:
    ///
    ///     S :: (a -> b -> c) -> (a -> b) -> a -> c
    ///     S f g x = f x (g x)
    ///
    /// Compare it to an idealized version of purely idiomatic Swiftiness:
    ///
    ///     @objc public static dynamic override func starlingCombinator<SomeParameterType, OtherParameterType, Result>(
    ///         _ anonymouFunction1: (@escaping (SomeParameterType) -> @escaping (OtherParameterType) -> Result) @escaping
    ///         -> (_ anonymouFunction2: @escaping (SomeParameterType) -> @escaping OtherParameterType)
    ///         -> (_ value: SomeParameterType) -> Result { @escaping @escaping @escaping@escaping@escaping@escaping
    ///             return @escaping anonymouFunction1(value)(anonymouFunction2(value)
    ///     }@escaping
    ///
    /// So beautiful. So elegant. So simple... So Swift.
    ///
    /// - Note: Some of these use the Greek alphabet for types as to not
    ///   conflict with the interdefined combinators. The greek alphabet is the
    ///   one that goes like this: Alpha, Beta, Charlie, Delta, Tiny E, Digamma,
    ///   Gamma, and H.
    public /*namespace*/ enum SKᵦ { }
}

extension λ.SKᵦ {

    // MARK: - SKI

    static func S <sA, sB, sC>(_ f: @escaping (sA) -> (sB) -> sC) -> (@escaping (sA) -> sB ) -> (sA) -> sC {
        return { g in { x in f⠀x⠀(g⠀x) } }
    }

    static func K <A>(_ x: A) -> (Any?) -> A {
        return const⠀x
    }

    static func Kꞌ <A, B>(_ x: A) -> (B) -> A {
        return const⠀x
    }

    static func I <A>(_ x: A) -> A {
        return S⠀K⠀K⠀x
    }

    // MARK: -

    /// A :: (a -> b) -> a -> b
    /// A = ($) = S⠀K⠀K
    static func A <A, B>() -> (@escaping (A) -> B) -> (A) -> B {
        return S⠀K⠀K
    }

    static func _B <A, B, C>() -> (@escaping (B) -> C) -> (@escaping (A) -> B) -> (A) -> C {
        return S (K⠀S)⠀K
    }

    static func B <bA, bB, bC>(_ f: @escaping (bB) -> bC) -> (@escaping (bA) -> bB) -> (bA) -> bC {
        return _B()(f)
    }

    /// B' :: (a -> c -> d) -> a -> (b -> c) -> b -> d
    /// B' = B B
    static func B´ <A, β, C, D>()
    -> (@escaping (A) -> (C) -> D)
    -> (A)
    -> (@escaping (β) -> C)
    -> (β) -> D {
        return B⠀B
    }

    /// B1 :: (c -> d) -> (a -> b -> c) -> a -> b -> d
    /// B1 = bluebird bluebird bluebird
    static func B1<A, β, C, D>()
    -> (@escaping (C) -> D)
    -> (@escaping (A) -> (β) -> C)
    -> (A) -> (β) -> D {
        // Cannot convert value of type
        // '(@e… (_) -> _) -> (@e… (_) -> _) -> (_) -> _' to '(_) -> _'
        //return B(B)(B)
        return λ.Aviary.blackbird
    }

    /// B2 :: (d -> e) -> (a -> b -> c -> d) -> a -> b -> c -> e
    /// B2 = bluebird (bluebird bluebird bluebird) bluebird
    static func B2<A, β, C, D, E>()
    -> (@escaping (D) -> E)
    -> (@escaping (A) -> (β) -> (C) -> D)
    -> (A) -> (β) -> (C) -> E {
        // Cannot convert value of type
        // '(@e… (_) -> _) -> (@e… (_) -> _) -> (_) -> _' to '(_) -> _'
        //return B(B(B)(B))(B)
        return λ.Aviary.bunting
    }

    /// B3 :: (c -> d) -> (b -> c) -> (a -> b) -> a -> d
    /// B3 = bluebird (bluebird bluebird) bluebird
    static func B3<A, β, C, D>()
    -> (@escaping (C) -> D)
    -> (@escaping (β) -> C)
    -> (@escaping (A) -> β)
    -> (A) -> D {
        // Cannot convert value of type
        // '(@escaping (_) -> _) -> (_) -> _' to '(_) -> _'
        //return B(B(B))(B)
        return λ.Aviary.becard
    }

    static func C <cA, cB, cC>(
    _ f: @escaping (cA) -> (cB) -> cC)
    -> (cB) -> (cA) -> cC {
        // Generic parameter 'A' could not be inferred
        //return S(B(B)(S))(K(K))(f)
        return flip⠀f
    }

    static func Cꞌ <A, B, C, D>()
    -> (@escaping (C) -> (A) -> D)
    -> (@escaping (B) -> C)
    -> (A) -> (B) -> D {
        // Cannot convert value of type '(@escaping (_) -> _) -> (@escaping (_) -> _) -> (_) -> _' to expected argument type '(_) -> _'
        //return B(B(C))(B)
        return λ.Aviary.cardinalPrime
    }

    static func C꘎ <A, β, Γ, Δ>(
    _ f: @escaping (A) -> (Γ) -> (β) -> Δ)
    -> (A) -> (β) -> (Γ) -> Δ {
        return B⠀C⠀f
    }

    static func C꘎꘎ <A, β, Γ, Δ, Z>()
    -> (@escaping (A) -> (β) -> (Δ) -> (Γ) -> Z)
    -> (A) -> (β) -> (Γ) -> (Δ) -> Z {
        return B (B⠀C)
    }

    /// dove :: (a -> c -> d) -> a -> (b -> c) -> b -> d
    /// dove = bluebird bluebird
    static func D <A, β, C, D>()
    -> (@escaping (A) -> (C) -> D)
    -> (A)
    -> (@escaping (β) -> C)
    -> (β) -> D {
        return B⠀B
    }

    /// dickcissel :: (a -> b -> d -> e) -> a -> b -> (c -> d) -> c -> e
    /// dickcissel = bluebird (bluebird bluebird)
    static func D1 <A, β, C, D, E>()
    -> (@escaping (A) -> (β) -> (D) -> E)
    -> (A) -> (β)
    -> (@escaping (C) -> D)
    -> (C) -> E {
        return B (B⠀B)
    }

    static func D2 <A, β, C, D, E>()
    -> (@escaping (C) -> (D) -> E)
    -> (@escaping (A) -> C)
    -> (A)
    -> (@escaping (β) -> D)
    -> (β) -> E {
        return B(B)(B⠀B)
    }

    static func E <A, β, C, D, E>(
    _ f: @escaping (A) -> (D) -> E)
    -> (A)
    -> (@escaping (β) -> (C) -> D)
    -> (β) -> (C) -> E {
        // Cannot convert value of type '(@escaping (_) -> _) -> (@escaping (_) -> _) -> (_) -> _' to expected argument type '(_) -> _'
        //return B(B(B)(B))
        return λ.Aviary.eagle⠀f
    }

    static func Ê <A, β, Γ, Δ, E, Z, H>()
    -> (@escaping (E) -> (Z) -> H)
    -> (@escaping (A) -> (β) -> E)
    -> (A) -> (β)
    -> (@escaping (Γ) -> (Δ) -> Z)
    -> (Γ) -> (Δ) -> H {
        // Takes around a year to fail to type check, give or take.
        // I advice you to try this on winter only, as well.
        //return B(B(B)(B))(B(B(B)(B)))
        return λ.Aviary.baldEagle
    }

    static func F <A, B, C>()
    -> (A) -> (B)
    -> (@escaping (B) -> (A) -> C)
    -> C {
        // Generic parameter 'A' could not be inferred
        //return E(T)(T)(E)(T)
        return λ.Aviary.finch
    }

    /// finchstar :: (c -> b -> a -> d) -> a -> b -> c -> d
    /// finchstar = bluebird cardinalstar robinstar
    static func F꘎ <A, β, Γ, Δ>(
    _ f: @escaping (Γ) -> (β) -> (A) -> Δ)
    -> (A) -> (β) -> (Γ) -> Δ {
        return B(C꘎)(R꘎)(f)
    }

    /// finchstarstar :: (a -> d -> c -> b -> e) -> a -> b -> c -> d -> e
    /// finchstarstar = bluebird finchstar
    static func F꘎꘎ <A, β, C, D, E>()
    -> (@escaping (A) -> (D) -> (C) -> (β) -> E)
    -> (A) -> (β) -> (C) -> (D) -> E {
        return B(F꘎)
    }

    static func G <A, β, Γ, Δ>()
    -> (@escaping (β) -> (Γ) -> Δ)
    -> (@escaping (A) -> Γ)
    -> (A) -> (β) -> Δ {
        return B(B)(C)
    }

    static func H <A, β, Γ>()
    -> (@escaping (A) -> (β) -> (A) -> Γ)
    -> (A) -> (β) -> Γ {
        return B(W)(B(C))
    }

    static func I꘎ <A, B>(
    _ f: @escaping ((A) -> B) -> A)
    -> (@escaping (A) -> B)
    -> A {
        return S (S⠀K)⠀f
    }

    static func I꘎꘎ <A, β, C>()
    -> (@escaping (A) -> (β) -> C)
    -> (A) -> (β) -> C {
        return B⠀I
    }

    static func J <A, β>()
    -> (@escaping (A) -> (β) -> β)
    -> (A) -> (β) -> (A) -> β {
        // Static method 'J()' took 601724ms to type-check (limit: 80ms)
        //return B(B(C))(W(B(C)(B(B(B)(B)))))
        return λ.Aviary.jay
    }

    static func Jꞌ <A, β, C>()
    -> (@escaping (A) -> C)
    -> (A) -> (β) -> C {
        return B⠀K
    }

    static func Jꞌꞌ <A, β, C, D>()
    -> (@escaping (A) -> (β) -> D)
    -> (A) -> (β) -> (C) -> D {
        return B (B⠀K)
    }

    /// Ki :: a -> b -> b
    /// Ki _x y = y
    static func Ki<A, B>() -> (A) -> (B) -> B {
        return K⠀I
    }

    /// O combinator
    static func O <A, B>()
    -> (@escaping ((A) -> B) -> A)
    -> (@escaping (A) -> B)
    -> B {
        return S ((S⠀K)⠀K)
    }

    public static func O´ <A, β, C, D>()
    -> (@escaping (A) -> (C) -> D)
    -> (A)
    -> (@escaping (β) -> C)
    -> (β) -> D {
        return B (B)
    }

    static func Φ <A, β, C, D>()
    -> (@escaping (β) -> (C) -> D)
    -> (@escaping (A) -> β)
    -> (@escaping (A) -> C)
    -> (A) -> D {
        // Cannot convert call result type '(@escaping (_) -> _) -> (_) -> _' to expected type '(_) -> _'
        //return B(B(S))(B)
        return λ.Aviary.phoenix
    }

    /// queer :: (a -> b) -> (b -> c) -> a -> c
    /// queer f g x = g (f x)
    static func Q <A, β, Γ>()
    -> (@escaping (A) -> β)
    -> (@escaping (β) -> Γ)
    -> (A) -> Γ {
        return C⠀B
    }

    static func Q1 <A, β, Γ>()
    -> (@escaping (β) -> Γ)
    -> (A)
    -> (@escaping (A) -> β)
    -> Γ {
        // Cannot convert value of type '(@escaping (_) -> (_) -> _) -> (_) -> (_) -> _' to expected argument type '(_) -> _'
        //return B(C)(B)
        return λ.Aviary.quixotic
    }

    static func Q2 <A, β, Γ>()
    -> (A)
    -> (@escaping (β) -> Γ)
    -> (@escaping (A) -> β)
    -> Γ {
        // Cannot convert value of type '(@escaping (_) -> (_) -> _) -> (_) -> (_) -> _' to expected argument type '(_) -> _'
        //return C(B(C)(B))
        return λ.Aviary.quizzical
    }

    static func Q3 <A, β, Γ>()
    -> (@escaping (A) -> β)
    -> (A)
    -> (@escaping (β) -> Γ)
    -> Γ {
        return λ.Aviary.quirky
    }

    static func R <A, β, Γ>()
    -> (A)
    -> (@escaping (β) -> (A) -> Γ)
    -> (β) -> Γ {
        // Cannot convert value of type '(@escaping (_) -> _) -> (@escaping (_) -> _) -> (_) -> _' to expected argument type '(_) -> _'
        //return B(B)(T)
        return λ.Aviary.robin
    }

    static func R꘎ <A, B, C, D>(
    _ f: @escaping (B) -> (C) -> (A) -> D)
    -> (A) -> (B) -> (C) -> D {
        // Cannot convert return expression of type '((_) -> (_) -> (_) -> _) -> (_) -> (_) -> (_) -> _' to return type '(A) -> (B) -> (C) -> D'
        return C꘎⠀C꘎⠀f
    }

    static func R꘎꘎ <A, β, Γ, Δ, E>()
    -> (@escaping (A) -> (Γ) -> (Δ) -> (β) -> E)
    -> (A) -> (β) -> (Γ) -> (Δ) -> E {
        return B⠀R꘎
    }

    static func S´ <A, β, Γ, Δ>()
    -> (@escaping (β) -> (Γ) -> Δ)
    -> (@escaping (A) -> β)
    -> (@escaping (A) -> Γ)
    -> (A) -> Δ {
        // Cannot convert call result type '(@escaping (_) -> _) -> (_) -> _' to expected type '(_) -> _'
        //return B (B (S)) (B)
        return λ.Aviary.starlingPrime
    }

    static func T <A, β>(_ a: A) -> (@escaping (A) -> β) -> β {
        return C⠀I⠀a
    }

    static func V <A, β>()
    -> (A) -> (β)
    -> (@escaping (A) -> (β) -> β)
    -> β {
        //Cannot convert value of type '(@escaping (_) -> (_) -> _) -> (_) -> (_) -> _' to expected argument type '(_) -> _'
        //return B(C)(T)
        return λ.Aviary.vireo
    }

    static func V꘎ <A, B, D>(
    _ f: @escaping (B) -> (A) -> (B) -> D)
    -> (A) -> (B) -> (B) -> D {
        return C꘎⠀F꘎⠀f
    }

    static func V꘎꘎ <A, β, Γ, E>()
    -> (@escaping (A) -> (Γ) -> (β) -> (Γ) -> E)
    -> (A) -> (β) -> (Γ) -> (Γ) -> E {
        return B⠀V꘎
    }

    static func W <A, B>(
    _ f: @escaping (A) -> (A) -> B)
    -> (A) -> B {
        return C(S)(I)(f)
    }

    static func W1 <A, B>()
    -> (A)
    -> (@escaping (A) -> (A) -> B)
    -> B {
        return C⠀W
    }

    static func W꘎ <A, β, Γ>(
    _ f: @escaping (A) -> (β) -> (β) -> Γ)
    -> (A) -> (β) -> Γ {
        return B⠀W⠀f
    }

    static func W꘎꘎ <A, β, Γ, Δ>()
    -> (@escaping (A) -> (β) -> (Γ) -> (Γ) -> Δ)
    -> (A) -> (β) -> (Γ) -> Δ {
        return B⠀W꘎
    }

    static func Y <A, B>(
    _ f: @escaping (@escaping (A) -> B) -> (A) -> B)
    -> (A) -> B {
        //return { a in S(K(S(I)(I)))(S(S(K(S))(K))(K(S(I)(I))))(f)(a) }
        return f⠀Y(f)
    }
}

// MARK: - "Run, you fools!"
//               - Some wizard

/// Application of juxtaposed literals and identifiers.
///
/// Sequentially apply functions to values using ML-notation.
///
/// ### Examples:
///
///     ƒ(ρ)(σ)(τ)(υ)
///     ƒ⠀ρ⠀σ⠀τ⠀υ
///
///     until(ρ)(λ)(λ(x))
///     until⠀ρ⠀λ⠀λ(x)
///
///     λ(fix(λ))(x)
///     λ⠀fix(λ)⠀x
///
/// ### Rationale
/// To match domain notation and facilitate the translation and preservation
/// of the λ calculus structural simplicity along with the ML-like languages
/// used as reference, simplifying complex expressions involving multi-layered
/// nested calls to polyadic curried functions—still reading? i did it cause
/// it's fun, alright, that's the rationale—deemed necessary to avoid variable
/// declarations spanning multiple lines of code.
@_transparent
fileprivate func⠀<A, B>(f: (A) -> B, x: A) -> B { return f(x) }
//@_transparent
//fileprivate func⠀<A, B>(x: A, f: (A) -> B) -> B { return f(x) }
@_transparent
fileprivate func⠀<A, B, C>(f: (A) -> (B) -> C, x: A) -> (B) -> C { return f(x) }
@_transparent
fileprivate func⠀<A, B, C>(f: (A) -> (B) -> C, x: () -> A) -> (B) -> C { return f(x()) }
@_transparent
fileprivate func⠀<A, B, C>(f: ((A) -> B) -> C, x: @escaping (A) -> B) -> C { return f(x) }

//@_transparent
//fileprivate func⠀<A, B, C, D>(f: (A) -> (B) -> (C) -> D, x: A) -> (B) -> (C) -> D { return f(x) }
//@_transparent
//fileprivate func⠀<A, B, C, D, E>(f: (A) -> (B) -> (C) -> (D) -> E, x: A) -> (B) -> (C) -> (D) -> E { return f(x) }

//@_transparent
//fileprivate func⠀<A, B, C>(f: (A) -> B, g: (B) -> C) -> (A) -> C {
//    return nonescaping(f) { f in
//        nonescaping(g) { g in
//            { x in g(f(x)) }
//        }
//    }
//}
//
//@_transparent
//fileprivate func⠀<A, B, C>(f: (B) -> C, g: (A) -> B) -> (A) -> C {
//    return nonescaping(f) { f in
//        nonescaping(g) { g in
//            { x in f(g(x)) }
//        }
//    }
//}

//@_transparent
//fileprivate func⠀<A, B>(
//    g: () -> (A),
//    ƒ: () -> (A) -> B
//) -> B {
//    return ƒ()(g())
//}
//
//@_transparent
//fileprivate func⠀<A, B>(
//    ƒ: () -> (A) -> B,
//    g: () -> (A)
//) -> B {
//    return ƒ()(g())
//}
//
//@_transparent
//fileprivate func⠀<A, B>(
//    ƒ: () -> (A) -> B,
//    g: A
//) -> B {
//    return ƒ()(g)
//}
//
//@_transparent
//fileprivate func⠀<A, B>(
//    g: A,
//    ƒ: () -> (A) -> B
//) -> B {
//    return ƒ()(g)
//}

//@_transparent
//fileprivate func⠀<A, B, C>(
//    ƒ: () -> ((A) -> B) -> C,
//    g: () -> (A) -> B
//) -> C {
//    return ƒ()(g())
//}
//
//@_transparent
//fileprivate func⠀<A, B, C>(
//    ƒ: ((A) -> B) -> C,
//    g: () -> (A) -> B
//) -> C {
//    return ƒ(g())
//}
//
//@_transparent
//fileprivate func⠀<A, B, C>(
//    ƒ: () -> ((A) -> B) -> C,
//    g: @escaping (A) -> B
//) -> C {
//    return ƒ()(g)
//}
//
//@_transparent
//fileprivate func⠀<A, B, C>(
//    ƒ: ((A) -> B) -> C,
//    g: @escaping (A) -> B
//) -> C {
//    return ƒ(g)
//}
//
//@_transparent
//fileprivate func⠀<A, B, C, D>(
//    ƒ: ((A) -> B) -> (C) -> D,
//    g: @escaping (A) -> B
//) -> (C) -> D {
//    return ƒ(g)
//}
//
////@_transparent
////fileprivate func⠀<A, B, C, D>(
////    ƒ: (@escaping (A) -> B) -> (C) -> D,
////    g: @escaping (A) -> B
////) -> (C) -> D {
////    return ƒ(g)
////}
//
//@_transparent
//fileprivate func⠀<A, B, C, D>(
//    ƒ: () -> (@escaping (A) -> B) -> (C) -> D,
//    g: () -> (A) -> B
//) -> (C) -> D {
//    return ƒ()(g())
//}
//
//@_transparent
//fileprivate func⠀<A, B, C, D>(
//    ƒ: (@escaping (A) -> B) -> (C) -> D,
//    g: () -> (A) -> B
//) -> (C) -> D {
//    return ƒ(g())
//}
//
//@_transparent
//fileprivate func⠀<A, B, C, D>(
//    ƒ: () -> ((A) -> B) -> (C) -> D,
//    g: @escaping (A) -> B
//) -> (C) -> D {
//    return ƒ()(g)
//}

/// Juxtapartiply™. Implicit partial application of binary functions via
/// whitespace juxtaposition in Swift?! Ridonkulous!
///
/// The perfect marriage between bad practices and dementia! Look at what
/// everyone is saying:
///
/// "Whoa." - [Bill & Ted](https://www.youtube.com/watch?v=FlRUmkqMIe8)
/// "We've decided to go in another direction, Mr. Pequeno." - All the clients!
/// "Are you mental?" - Programmer who talked like harry potter
/// "I knew you wouldn't amount to anything." - Mom
/// "I believe that the best course of action at this time is to terminate
///  this relationship effective immediately, Mr. Pequeno." - Girlfriend, ex.
/// "Yes, yes!" - Emperor Palpatine
/// "Genius!" - A parrot after hearing the word
//@_transparent
//fileprivate func⠀<A, B, C>(ƒ: @escaping (A, B) -> C, a: A) -> (B) -> C {
//    return curry⠀ƒ⠀a
//}

infix operator⠀: λApplicationPrecedence //l⁺ ⌥2800

// MARK: -
// hacks even horribler than the whitespace thing

//@_transparent
//func _S<A, B, C>(_ f: (A) -> (B) -> C) -> ((A) -> B) -> (A) -> C {
//    return nonescaping(f) { { [f = $0] g in { a in f(a)(g(a)) } } }
//}
