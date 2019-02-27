// µlude: noun. A tiny Prelude.
// └╴⌥m

/// When nine people agree on something, it’s the tenth man’s
/// responsibility to disagree no matter how improbable the idea.

// MARK: - Extended aliases

/// Denotes a parameter whose argument will be ignored no matter what's passed.
public typealias UnboundVar = Moniker<Tag.UnboundVar, () -> Any?>

/// An alternative representation of an omitted argument
public typealias · = UnboundVar

/// Denotes a missing argument when given to a function, triggering its
/// partial application.
public let __  = UnboundVar { () as Any? }

/// A nominal type that represents `nil` values. A trivial generalization
/// of _OptionalNilComparisonType.
///
/// `Nil` can enable pattern matching and equality operations against `nil`
/// for any `ExpressibleByNilLiteral` even if such type isn't `Equatable`.
public typealias Nil = _OptionalNilComparisonType

extension Nil: Equatable {

    /// Enables equality between nil values with no type context or
    /// `Equatable` conformance requirements.
    ///
    /// - Parameters:
    ///   - lhs: A `nil` literal, `Optional.none` or instance of `Nil`.
    ///   - rhs: A `nil` literal, `Optional.none` or instance of `Nil`.
    @_transparent // primitive
    public static func == (lhs: Nil, rhs: Nil) -> Bool {
        return true
    }
}

// MARK: - Base combinators

/// Returns the given argument.
///
/// By directly returning the given argument, the identity function can help
/// turn closures and chained-calls of composable functions into declarative
/// sentences by facilitating pointfree style on certain circumstances.
///
///     [0, 1?, 2, 3?].compactMap(id) // == [0, 2]
///
/// Given an `Optional` closure `transform`:
///     request(..., response: { $0.result.map(transform ?? itself) })
///
/// - Parameter a: A value.
/// - Returns: The value.
@_transparent // primitive
internal func id<A>(_ a: A) -> A {
    return a
}

/// Returns a unary function that ignores any argument passed returning
/// the original value that was given to `const`.
///
/// This is a non-standard variant of the constant function that extends
/// its courtesy to empty tuples and avoids unnecessary partial specialization
/// of the unbound parameter which in turn enables the partial application
/// of this function.
///
///     let r = const(0)(1)   // r == 0
///     let a = const("")     // (UnboundAny) -> String
///     let b = const(())     // (UnboundAny) -> ()
///     a(0)                  // r == ""
///     b("some")             // r == ()
///
/// - Parameter a: A value.
/// - Returns: A unary function that ignores its argument and returns `a`.
@_transparent
internal func const<A>(_ a: A) -> (Any?) -> A {
    return { _ in a }
}

/// Returns a function that takes any number of arguments and returns nil.
///
/// This is a non-standard variant of the constant function that extends
/// its courtesy to nil values.
///
///     let ø = const(nil)(0) // ø == nil
///
/// - Parameter a: A `nil` value.
/// - Returns: A unary function that ignores its argument and returns `a`.
internal let const = Aviary.const ◦ Type.annotate(Nil.self)

/// Returns the empty tuple `()`, discarding the given argument.
///
/// - Parameter _: A value to discard.
/// - Returns: The empty tuple.
@_transparent // primitive
internal func void(_: ·) -> () {
    return ()
}

/// Returns the given value `x` duplicated as a pair of `xs`, effectively
/// performing `xs = (x, x)`, or `(id &&& id)(x)`.
///
/// "Twins, Basil. Twins!"
///     - Austin Powers in Goldmember, 2002.
///       Renowned functional programmer.
///
/// ### Example
///     let twins = dupe(a) // (A, A)
///     twins.0 == twins.1 // is true
///
///     if case (.denied, .restricted) = dupe(authEnum) {
///         print("denied!")
///     }
///
/// - Parameter x: A value.
/// - Returns: The value duplicated in a pair.
@_transparent
internal func dupe<A>(_ a: A) -> (A, A) {
    return (a, a)
}

/// Returns a repetition function that will produce a `Repeated` collection
/// replicating any instance of `Element` by the initial count provided.
///
/// This is a flip and curried variant of Swift's `repeatElement` free function
/// found in the stdlib under the `Repeated` type implementation aimed at
/// pointfree style, reusability and composability.
///
///     let tenOf = replicate(times: 10) ◦ Type.annotate(UIView.self)
///     tenOf(0.0/0).forEach { print($0, terminator: "") }
///     print( batman!")
///     // prints "nannannannannannannannannannan batman!"
///         print(x, terminator: "")
///     }
///
/// - Parameters:
///   - element: The element to repeat.
///   - count: The number of times to repeat `element`.
/// - Returns: A collection that contains `count` elements that are all
///   `element`.
@inlinable
internal func replicate<Element>(_ n: Int) -> (Element) -> Repeated<Element> {
    return partial(repeatElement, __, n)
}

/// Returns the value associated with the given `KeyPath` on the given `Root`.
///
/// A very turing incomplete implementation of lenses.
@_transparent
internal func get <Root, Value>(
    _ path: KeyPath<Root, Value>
) -> (Root) -> Value {
    return { $0[keyPath: path] }
}

// MARK: -

enum Type {

    // MARK: Checking

    /// Forces the type checker to infer the type of a generic instance.
    ///
    /// When done within expressions already dealing in generics, it may force
    /// the type checker to resolve `A` by taking into account the generic
    /// context put forward by the expression.
    ///
    /// - Requires: The instance and the context must be the same type.
    /// - Parameter a: The instance to infer.
    /// - Returns: The instance inferred or fails to compile.
    @_transparent
    static func infer<A>(_ a: A) -> A {
        return id(a)
    }

    /// Returns the identity function annotated with the given type.
    ///
    /// The identity function returned will compile if and only if it is given
    /// instances of the annotated type.
    @_transparent
    static func annotate<A>(_ : A.Type) -> (_ to: A) -> A {
        return id
    }

    /// Returns a function indicating whether any instance it is given is of
    /// type `A`.
    ///
    /// A functional, higher-order variant of the type checking infix `is`.
    @_transparent
    static func `is`<A>(_: A.Type) -> (Any) -> Bool {
        return { $0 is A }
    }

    // MARK: Casting

    /// Returns an `Optional` with `a` downcasted as a `B` or `nil` if the operation
    /// attempt is unsuccessful.
    ///
    /// This is a functional variant of the conditional type cast infix `as?`.
    ///
    /// - Precondition: Success depends on `a` actually being of type `B`.
    @_transparent
    static func cast<A, B>(_ a: A) -> B? {
        return a as? B
    }

    /// Attempts to coerce the given instance by inferring the context or _crashes
    /// spectacularly.
    ///
    /// - Requires: For `a` to be a real `B`.
    @_transparent
    static func coerce<A, B>(_ a: A) -> B {
        return a as! B
    }

    /// Attempts to reinterpret `a` exposing it as the real `B` it is, or
    /// _crashes horribly._
    ///
    /// This cast can be useful for dispatching to specializations of generic
    /// functions.
    ///
    /// - Requires: For `a` to have always been `B`, even after all this time.
    @_transparent
    static func expose<A, B>(_ a: A) -> B {
        return _identityCast(a, to: B.self)
    }
}

// MARK: - Operators

// Functional Operator Compendium Keep, or FOCK for short.
//
//  • Thoroughly researched
//  • Universal applications (non-domain specific)
//  • precedent wide established with Art of Terms
//  • Standardizwed precedence group across a dozen languages
//  • Nothing in here is an invention
//
// Feel free to experiment, borrow what you want and piss your coworkers off.

// It is recommended to style Comments in non-Italic with 50% opacity

// MARK: Precedence Group Reference Table

///  ╌────────────────────────────────────────────────╌
///   ∎        Precedence Group Table
///  ╌────────────────────────────────────────────────╌
///
///          name                                   eg  fix ❭λ=
///       ╷·╶────────────────────────────────────────╴·╷
//        │  AssignmentPrec. &= |= ^= %= /= *= += -= = │ r⁻
///       │  FunctionArrowPrecedence            ->  <| │ r⁰ $
///       │  FunctionMapPrecedence          .^ >>=  |> │ l¹ & <&> >>  >>= =>>
///       │  CompositionPrecedence     <<< <=< >=> >>> │ r¹   >>> >=> =<< <<=
//        │  TernaryPrecedence                      ?: │ r¹
//        │  DefaultPrecedence                         │  ²
///       │  DisjunctionPrecedence             <|>  || │ l²    <|> >|<
///       │  CompetitionPrecedence             +++ ||| │ r² || ||| +++
///       │  ConjunctionPrecedence                  && │ l³
///       │  CooperationPrecedence             *** &&& │ r³ && &&& ***
//        │  ComparisonPrecedence      ~= == ≠ < > ≤ ≥ │  ⁴ .= ?= %= += -= *= /=
///       │  ApplicationPrecedence             <*> <•> │ l⁴ <$> <*> <@> >$< >*<
///       │  LensingPrecedence                •~ ?= .= │ r⁴ .~ ?~ %~ +~ -~ *~ /~
//        │  NilCoalescingPrecedence                ?? │ r⁴
//        │  CastingPrecedence           is as as? as! │  ⁵
//        │  RangeFormationPrecedence          ... ..< │  ⁵
///       │  AmalgamationPrecedence                 ++ │ r⁵ ++ :+:
//        │  AdditionPrecedence          | ^ &- &+ - + │ l⁶
///       │  CartesianPrecedence                    <> │ r⁶ <> :*:
//        │  MultiplicationPrecedence & &% &/ &* % / * │ l⁷
///       │  ExponentiationPrecedence               ** │ r⁸ ^ ^^ **
//        │  BitwiseShiftPrecedence              << >> │  ⁹
///       │  λApplicationPrecedence                  • │ l⁹
///       │  λCompositionPrecedence                  ◦ │ r⁹ .
//        │  _unnamed invocation precedence_        () │ l⁺ ⎵
///       ╵·╶────────────────────────────────────────╴·╵

// MARK: Precedence Group Declarations

//              AssignmentPrecedence      ┌in.rα┐  { associativity: right assignment: true }
//              FunctionArrowPrecedence   ╽in.r0╽  { associativity: right ...
precedencegroup FunctionMapPrecedence   /*╽in.l1╽*/{ associativity: left  higherThan: FunctionArrowPrecedence      lowerThan: TernaryPrecedence }
//              TernaryPrecedence         ╽in.r1╽  { associativity: right ... }
//              DefaultPrecedence         ╽in. 2╽  { associativity: none  ... }
precedencegroup DisjunctionPrecedence   /*╽in.l2╽*/{ associativity: left  higherThan: LogicalDisjunctionPrecedence lowerThan: ComparisonPrecedence }
precedencegroup CompetitionPrecedence   /*╽in.r2╽*/{ associativity: right higherThan: DisjunctionPrecedence        lowerThan: ComparisonPrecedence }
precedencegroup ConjunctionPrecedence   /*╽in.l3╽*/{ associativity: left  higherThan: LogicalConjunctionPrecedence lowerThan: ComparisonPrecedence }
precedencegroup CooperationPrecedence   /*╽in.r3╽*/{ associativity: right higherThan: ConjunctionPrecedence        lowerThan: ComparisonPrecedence }
//              ComparisonPrecedence      ╽in. 4╽  { associativity: none  ... }
precedencegroup ApplicationPrecedence   /*╽in.l4╽*/{ associativity: left  higherThan: ComparisonPrecedence         lowerThan: NilCoalescingPrecedence }
precedencegroup LensingPrecedence       /*╽in.r4╽*/{ associativity: right higherThan: ApplicationPrecedence        lowerThan: NilCoalescingPrecedence }
//              NilCoalescingPrecedence   ╽in.r4╽  { associativity: right ... }
//              CastingPrecedence         ╽in. 5╽  { associativity: none  ... }
//              RangeFormationPrecedence  ╽in. 5╽  { associativity: none  ... }
precedencegroup AmalgamationPrecedence  /*╽in.r5╽*/{ associativity: right higherThan: RangeFormationPrecedence     lowerThan: AdditionPrecedence }
//              AdditionPrecedence        ╽in.l6╽  { associativity: left ... }
precedencegroup CartesianPrecedence     /*╽in.r6╽*/{ associativity: right higherThan: AdditionPrecedence           lowerThan: MultiplicationPrecedence }
//              MultiplicationPrecedence  ╽in.l7╽  { associativity: left ... }
precedencegroup ExponentiationPrecedence/*╽in.r8╽*/{ associativity: right higherThan: MultiplicationPrecedence     lowerThan: BitwiseShiftPrecedence }
//              BitwiseShiftPrecedence    ╽in. 9╽  { associativity: none ... }
precedencegroup λApplicationPrecedence  /*╽in.l9╽*/{ associativity: left  higherThan: BitwiseShiftPrecedence }
precedencegroup λCompositionPrecedence  /*┗in.rω┛*/{ associativity: right higherThan: λApplicationPrecedence }

// MARK: Declarations

// MARK: Syntactic

infix operator ′ : λApplicationPrecedence // infix functions // MARK: ⠀⠀infix ′

// MARK: Lenses

// Lens getter
prefix operator ^ // get: ^\Root.key.path // MARK: ⠀⠀prefix ^

infix operator .= : AssignmentPrecedence  //  =   root  .= \.path    // MARK: ⠀⠀infix .=
infix operator .^ : FunctionMapPrecedence // get  root  .^ \.path    // MARK: ⠀⠀infix .^
infix operator .~ : LensingPrecedence     // set  path  .~   value   // MARK: ⠀⠀infix .~
infix operator ?~ : LensingPrecedence     // set? path? ?~   value   // MARK: ⠀⠀infix ?~
infix operator %~ : LensingPrecedence     // map  path  •~ { value } // MARK: ⠀⠀infix •~

// MARK: Arithmetic

/// The missing exponentiation operator, as recommended by the Swift core team.
/// https://github.com/apple/swift/blob/master/docs/StdlibRationales.rst#swift-power-operator
infix operator **  : ExponentiationPrecedence
infix operator **= : AssignmentPrecedence

/// (.*) ∷ Scalar (×) and Hadamard (⊙) products.
/// (./) ∷ Scalar (÷) and Hadamard (⊘) quotients.
infix operator .* : MultiplicationPrecedence // MARK: ⠀⠀infix .*
infix operator ./ : MultiplicationPrecedence // MARK: ⠀⠀infix ./
infix operator .+ : AdditionPrecedence       // MARK: ⠀⠀infix .+
infix operator .- : AdditionPrecedence       // MARK: ⠀⠀infix .-

/// Vector products ∷ dot, cross, wedge
/// https://physics.info/vector-multiplication/
infix operator ∙  : MultiplicationPrecedence // Dot   (inner)    ⌥22C5 ⌥>
infix operator ×  : MultiplicationPrecedence // Cross            ⌥2A2F ⌥x
infix operator ∧  : MultiplicationPrecedence // Wedge (exterior) ⌥2314 ⌥v
infix operator ⊗  : MultiplicationPrecedence // Tensor (outer)   ⌥2A2F ⌥X

// MARK: Quantifiers
// file:///./Prelude/Data/Quantification.swift

prefix operator ∀  // all  satisfy 𝑃   | ⌥2200 ⌥A    // MARK: ⠀⠀infix ∀
prefix operator ∃  // some satisfy 𝑃   | ⌥2203 ⌥E    // MARK: ⠀⠀infix ∃
prefix operator ∃! // uniq satisfies 𝑃 | ⌥2203 ⌥E    // MARK: ⠀⠀infix ∃!
prefix operator ∄  // none satisfies 𝑃 | ⌥2204 ⌥/+E  // MARK: ⠀⠀infix ∄

// MARK: Higher-order infixes

///  Swift algebraic data type system reference
///
///  ╔─────────────────╦────────╦──────────────╦─────────────────────────╗
///  │ ▓▒░ Algebra ░▒▓ │ ▒ Op ▒ │ ▓▒░ Cons ░▒▓ │ ░▒▓▓▒░ Data-type ░▒▓▓▒░ │
///  ╠─────────────────╬────────╬──────────────╬─────────────────────────╣
///  │ bottom          │   ⟘    │ -            │ Never                   │
///  │ unit            │   ∅    │ ()           │ Void                    │
///  │ sum             │   +    │ enum         │ Semigroup, Either, Opt. │
///  │ product         │   *    │ struct, (,)  │ Monoid, Collection      │
///  │ exponential     │   ^    │ func         │ Set, Category           │
///  │ function        │ · -> · │ generics     │ Type-class (PATs)       │
///  │ recursive       │   x!   │ indirect     │ Indirect enums          │
///  │ higher-kinded   │ * -> * │              │                         │                        lib:Swiftz──────────┐
///  │ top-type        │   ⟙    │ [all types]  │ Any                     │                        lib:Pointfree───┐   │
///  ╚─────────────────╩────────╩──────────────╩─────────────────────────╝                        Purescript──┐   │   │
///                                                                                               Haskell─┐   │   │   │          * "compose" infix func:
///  ╌─────────────────────────────────────╌─────┬────────────────┬───┬─────────────────────────────────┯─┴─┯─┴─┯─┴─┯─┴─┯─────┯─────┯─────┯────┯────┑
/// Unconstrained polymorphism              infix│operation       │ # │signature                        ╽λ= ╽PS ╽Pf ╽Swz╽OCaml╽Scala╽ Elm ╽Elxr╽Erlg│
infix operator ◦   : λCompositionPrecedence// r⁹ ¦compose         ¦ 25¦(b -> c) -> (a -> b) -> a->c     ┃ . ┃ . ┃   ┃   ┃  %  ┃comp*┃     ┃    ┃    │ // MARK: ⠀⠀infix ◦
infix operator ^   : λApplicationPrecedence// l⁹ ¦apply           ¦  6¦(a -> b) -> a -> b               ┃ ␣ ┃ ␣ ┃   ┃   ┃  ␣  ┃  ␣  ┃  ␣  ┃ ␣  ┃ ␣  │ // MARK: ⠀⠀infix •
infix operator >>> : TernaryPrecedence     // r¹ ¦then            ¦ 22¦(a -> b) -> (b -> c) -> a->c     ┃>>>┃>>>┃>>>┃>>>┃  %> ┃ >>> ┃  >> ┃    ┃    │ // MARK: ⠀⠀infix >>>
infix operator |>  : FunctionMapPrecedence // l¹ ¦pipe            ¦217¦a -> (a -> b) -> b               ┃ & ┃ # ┃|> ┃|> ┃ |>  ┃ |>  ┃ |>  ┃ |> ┃    │ // MARK: ⠀⠀infix |>
infix operator |>> : FunctionMapPrecedence // l¹ ¦tap             ¦ 16¦a -> (a -> _) -> a               ┃   ┃   ┃   ┃   ┃     ┃     ┃     ┃    ┃    │
///                                      ╌╌──────┼─────────┬──────┼───┼─────────────────────────────────╇───╇───╇───╇───╇─────╇─────╇─────╇────╇────┩
/// Invariant                               infix│op       ¦aka   │ # │signature                        ╽λ= ╽PS ╽*Pf╽Swz╽OCaml╽Scala╽ Elm ╽Elxr╽Erlg│
infix operator ++  : AmalgamationPrecedence// r⁶ ¦combine  ¦append¦ 46¦([a], a') -> [a₁, a₂, ···, a']   ┃++ ┃ @ ┃<> ┃   ┃  @  ┃ ++  ┃ ++  ┃ ++ ┃ ++ │ // MARK: ⠀⠀infix ++
infix operator <|> : DisjunctionPrecedence // l² ¦alt,`??` ¦      ¦ 14¦a -> b -> Either(a || b)         ┃<|>┃<|>┃<|>┃   ┃ <|> ┃ <|> ┃  xor┃    ┃    │ // MARK: ⠀⠀infix <|>
infix operator ++= : AssignmentPrecedence  //    ¦         ¦      ¦ 15¦                                 ┃   ┃   ┃   ┃   ┃     ┃     ┃     ┃    ┃    │
///                                      ╌╌──────┼─────────┼──────┼───┼─────────────────────────────────╇───╇───╇───╇───╇─────╇─────╇─────╇────╇────┩
/// Covariant                               infix│operation│aka   │ ##│signature/notes                  ╽λ= ╽PS ╽*Pf╽Swz╽OCaml╽Scala╽ Elm ╽Elxr╽Erlg│
infix operator <*> : ApplicationPrecedence // l⁴ ¦apply    ¦ap    ¦ 12¦(a -> b)↑-> a↑ -> b↑             ┃<*>┃<*>┃<*>┃<*>┃ <*> ┃ <*> ┃|>app┃<~> ┃    │ // MARK: ⠀⠀infix <*>
infix operator <^> : ApplicationPrecedence // l⁴ ¦map      ¦fmap  ¦ 37¦(a -> b) -> a↑ -> b↑             ┃<$>┃<$>┃<¢>┃<^>┃     ┃ >|  ┃|>map┃<|> ┃    │ // MARK: ⠀⠀infix <•>
infix operator >=> : TernaryPrecedence     // r¹ ¦kleisli  ¦fish  ¦  4¦(a -> b↑) -> (b -> c↑) -> a -> c↑┃>=>┃>=>┃>=>┃>->┃ >=> ┃ >=> ┃     ┃    ┃    │ // MARK: ⠀⠀infix >=>
infix operator =>> : FunctionMapPrecedence // l¹ ¦coflatMap¦cobind¦  0¦a↑ -> (a↑ -> b) -> b↑            ┃   ┃   ┃   ┃   ┃     ┃     ┃     ┃    ┃    │
infix operator >>= : FunctionMapPrecedence // l¹ ¦flatMap  ¦bind  ¦ 10¦a↑ -> (a -> b↑) -> b↑            ┃>>=┃>>=┃   ┃>>-┃ >>= ┃ >>= ┃|>and┃~>> ┃    │ // MARK: ⠀⠀infix >>=
///                                      ╌╌──────┼─────────┼──────┼───┼─────────────────────────────────╇───╇───╇───╇───╇─────╇─────╇─────╇────╇────┩
/// Contravariant                           infix│op       │aka   │ ##│notes                            ╽   ╽   ╽   ╽   ╽     ╽     ┃     ┃    ┃    │
infix operator >*< : ApplicationPrecedence // l⁴ ¦divide   ¦      ¦  0¦Divisible                        ┃   ┃   ┃   ┃   ┃     ┃     ┃     ┃    ┃    │
infix operator >^< : ApplicationPrecedence // l⁴ ¦contramap¦pull  ¦  0¦Contravariant                    ┃   ┃   ┃   ┃   ┃     ┃     ┃     ┃    ┃    │
infix operator >|< : ConjunctionPrecedence // l² ¦decide   ¦      ¦  0¦Decidable                        ┃   ┃   ┃   ┃   ┃     ┃     ┃     ┃    ┃    │
infix operator =›= : TernaryPrecedence     // r¹ ¦cokleisli¦comp  ¦  0¦Cokleisli                        ┃   ┃   ┃   ┃   ┃     ┃     ┃     ┃    ┃    │
///                                      ╌╌──────┼─────────┼──────┼───┼─────────────────────────────────╇───╇───╇───╇───╇─────╇─────╇─────╇────╇────┩
/// Provariant                              infix│op       │aka   │ # │notes                            ╽λ= ╽PS ╽*Pf╽Swz╽OCaml╽Scala╽ Elm ╽Elxr╽Erlg│
infix operator *** : CooperationPrecedence // r³ ¦split    ¦prod  ¦  6¦enc. struct (prod-type)          ┃***┃***┃   ┃***┃ *** ┃ *** ┃     ┃    ┃    │ // MARK: ⠀⠀infix ***
infix operator &&& : CooperationPrecedence // r³ ¦fanout   ¦and   ¦ 12¦encodes parallelism              ┃&&&┃&&&┃   ┃&&&┃ &&& ┃ &&& ┃     ┃    ┃    │ // MARK: ⠀⠀infix &&&
infix operator +++ : CompetitionPrecedence // r² ¦splat    ¦sum   ¦  0¦encodes enum (sum-type)          ┃+++┃+++┃   ┃+++┃ +++ ┃ +++ ┃     ┃    ┃    │ // MARK: ⠀⠀infix +++
infix operator ||| : CompetitionPrecedence // r² ¦fanin    ¦xor   ¦  3¦encodes choice                   ┃|||┃|||┃   ┃|||┃ ||| ┃ ||| ┃     ┃    ┃    │ // MARK: ⠀⠀infix |||
///  ╌────────────────────────────────────╌──────┴─────────┴──────┴───┴─────────────────────────────────┻───┻───┻───┻───┻─────┻─────┻─────┻────┻────┛

// MARK: Converse variants

infix operator  <| : FunctionArrowPrecedence  // # 17
infix operator <<< : TernaryPrecedence        // # 9
infix operator <=< : TernaryPrecedence
infix operator =‹= : TernaryPrecedence
infix operator <<= : TernaryPrecedence
infix operator =<< : TernaryPrecedence

// MARK: Reserved

infix operator  <>   : CartesianPrecedence   // Semigroupal combine
infix operator <<•>> : ApplicationPrecedence // Bifunctorial bimap
infix operator <<*>> : ApplicationPrecedence // Biapplicative biapply


///   ╌──────────────────────────────────────────────────╌
///    ∎         Operator Fixity in Haskell . ❭λ=
///   ╌──────────────────────────────────────────────────╌
///     [Haskell]: https://haskell-lang.org
///
///     level    op      ƒ/sym                  context
///  ┏╌──────────────╌┓┏╌────────────────────╌┓┏╌─────────────────────────────╌╴
///  │ infixr 9  comp ││ .                    ││ · ƒ (Function composition)
//   │ infixl 9  idx  ││ !!                   ││ · List
//   │ infixr 8  exp  ││ int ^ ^^             ││
//   │                ││ float **             ││
///  │ infixl 8  get  ││ ^. ^@.               ││ · Lenses
///  │ infixr 7  cons ││ :.:                  ││ · ƒ (Functor composition)
//   │ infixl 7  prod ││ * /                  ││
///  │ infixr 6  cons ││ :*:                  ││ · ƒ (Tuple (Product))
///  │           comb ││ mappend <>           ││ · Semigroup ⟹ Monoid
//   │ infixl 6  sum  ││ + -                  ││
///  │ infixr 5  cons ││ :+:                  ││ · Sum-type (Coproduct)
///  │           comb ││ <+>                  ││ · ArrowPlus
///  │           seq  ││ append ++            ││ · List
//   │                ││ :|                   ││ · NonEmpty
//   │                ││ :< >< <| |>          ││ · Sequence
//   │ infixl 5       ││ :>                   ││
///  │ infixr 4  set  ││ .~ ?~ %~ +~ -~ *~ /~ ││ · Lenses
///  │                ││ .= ?= %= += -= *= /= ││
///  │ infixl 4  map  ││ fmap <$> <$ $>       ││ · Functor
///  │                ││ ap   <*> <* *> <**>  ││   ⟹ Applicative
//   │                ││ coap <@> <@ @> <@@>  ││   ⟹ Coapplicative (Comonad)
//   │                ││ imap <$$>            ││   ⟹ Invariant
//   │                ││ cmap >$< >$ $< >$$<  ││ · Contravariant Functor
//   │                ││ ap   >*<             ││   ⟹ Divisible (Contrapplicative)
//   │                ││ ap   <.> <. .> <..>  ││ · Apply (Semigroupoid)
///  │           get  ││ ^. ^?                ││ · Reference (general lenses)
///  │           set  ││ .= !̇=                ││
///  │           map  ││ .~ !~ .- !- !|       ││
//   │ infix  4  rel  ││ == /=                ││
//   │                ││ < <= >= >            ││
//   │ infixr 3  conj ││ &&                   ││
///  │                ││ &&& ***              ││ · Arrow (Stronk Profunctor)
///  │ infixl 3  xor  ││ <|>                  ││ · MonadPlus (Alternative)
///  │                ││ >|<                  ││ · Decidable (Contravariant)
//   │ infixr 2  disj ││ ||                   ││
///  │                ││ ||| +++              ││ · Arrow (Choice Profunctor)
///  │ infixl 2  cons ││ :!:                  ││ · Pair (strict)
//   │ infixr 1  comp ││ pre  ^>> >>^         ││ · Kleisli
//   │                ││ post ^<< <<^         ││
///  │                ││ comp <<< >>>         ││ · Functor (Category)
///  │                ││      -<- ->-         ││   ⟹ Bind
///  │                ││      <=< >=>         ││   ⟹ Monad
///  │                ││      =<= =>=         ││   ⟹ Comonad
///  │           bind ││ bind -<<             ││   ⟹ Bind
///  │                ││      =<<             ││   ⟹ Monad
///  │                ││      <<=             ││   ⟹ Comonad
///  │ infixl 1       ││      >>- >>= =>> >>  ││
///  │                ││ fmap <&>             ││
///  │                ││ ap &                 ││ · ƒ
///  │ infixr 0       ││ ap $                 ││
//   │ infixl 0       ││ on                   ││ · ƒ
///  ┗╌──────────────╌┛┗╌────────────────────╌┛┗╌─────────────────────────────╌╴

// MARK: - Semigroupoid

// A lack of Higher kinded types and the structural nature of function types
// in the Swift type system make it very difficult to declare the kind of
// typeclasses/protocols we require. We workaround this by using our imagination.

/// Returns a new function composing two functions by passing the output of the
/// inner function `g` to the input of the outer function `f`.
///
/// Right-to-left composition, although seemingly unintuitive, ultimately
/// provides the best shot at writing code that reads as a declaration of
/// intention as opposed to a set of instructions:
///
///     let computePoints = sum ◦ map(points) ◦ filter(wasSpoken)
///
/// Reads "let computePoints be the sum of every point that was spoken."
/// Whereas its counterpart:
///
///     let computePoints = { entries in
///         entries |> filter(wasSpoken) >>> map(points) >>> sum
///     }
///
/// Reads "let computePoints for many entries be: take the entries, keep the
/// ones that were spoken, transform every entry into a point, sum them."
/// Pointful style is necessary since otherwise:
///
///     let totalPoints = filter(wasSpoken) >>> map(points) >>> sum
///
/// Makes little sense on its own.
///
/// ### Non-composed equivalence
/// A right-to-left composition expression:
///
///     let computePoints = sum ◦ map(points) ◦ filter(wasSpoken)
///     let result = computePoints(entries)
///
/// is equivalent to the following closure expression:
///
///     let computePoints = { entries in sum(map(points)(filter(wasSpoken)(entries))) }
///     let result = computePoints(entries)
///
/// - Parameters:
///     - f: The outer function.
///     - g: The inner function.
/// - Returns: A function [composing `f` and `g`.
/// - SeeAlso:
///   https://en.wikipedia.org/wiki/Function_composition
@_transparent
func ◦ <A, B, C>( // ⌥,
    f: @escaping (B) -> C,
    g: @escaping (A) -> B
) -> (A) -> C {
    return { a in f(g(a)) }
}

/// Returns a new function composing two functions by passing the output of the
/// inner function `g` to the input of the outer function `f`.
///
/// - Parameters:
///     - f: The outer function.
///     - g: The inner function.
/// - Returns: A function composing `f` and `g`.
/// - SeeAlso:
///   https://en.wikipedia.org/wiki/Function_composition
@_transparent
func >>> <A, B, C>(
    g: @escaping (A) -> B,
    f: @escaping (B) -> C
) -> (A) -> C {
    return { a in f(g(a)) }
}

/// Returns a new function composing two functions by passing the output of the
/// inner function `g` to the input of the outer function `f`.
///
/// Right-to-left composition, although seemingly unintuitive, ultimately
/// provides the best shot at writing code that reads as a declaration of
/// intention as opposed to a set of instructions:
///
///     let computePoints = sum ◦ map(points) ◦ filter(wasSpoken)
///
/// Reads "let computePoints be the sum of every point that was spoken."
/// Whereas its counterpart:
///
///     let computePoints = { entries in
///         entries |> filter(wasSpoken) >>> map(points) >>> sum
///     }
///
/// Reads "let computePoints for many entries be: take the entries, keep the
/// ones that were spoken, transform every entry into a point, sum them."
/// Pointful style is necessary since otherwise:
///
///     let totalPoints = filter(wasSpoken) >>> map(points) >>> sum
///
/// Makes little sense on its own.
///
/// ### Non-composed equivalence
/// A right-to-left composition expression:
///
///     let computePoints = sum ◦ map(points) ◦ filter(wasSpoken)
///     let result = computePoints(entries)
///
/// is equivalent to the following closure expression:
///
///     let computePoints = { entries in sum(map(points)(filter(wasSpoken)(entries))) }
///     let result = computePoints(entries)
///
/// - Parameters:
///     - λ: The outer function.
///     - g: The inner function.
/// - Returns: A function composing `f` and `g`.
/// - SeeAlso:
///   https://en.wikipedia.org/wiki/Function_composition
@_transparent
func <<< <A, B, C>(
    f: @escaping (B) -> C,
    g: @escaping (A) -> B
) -> (A) -> C {
    return { a in f(g(a)) }
}

// MARK: - Tags

public enum /*namespace*/ Tag {
    public enum UnboundVar { }
    public enum PartiallyAppliedInfix { }
}
