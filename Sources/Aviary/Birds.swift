import Swift

//          ╌───────────────────────────────────────────────────╌             //
//           ∎  I love functional programming, It takes smart                 //
//             people who would otherwise be competing with me                //
//             and turns them into unemployable crazies.                      //
//                                          - William Morgan   ∎              //
//          ╌───────────────────────────────────────────────────╌             //

extension λ {

    /// Aviary
    ///
    /// Only birds present in the book To Mock a Mockingbird.
    ///
    /// ### Conventions
    ///   - Single letter types, arguments and predicates in ascending order.
    ///   - Function argument labels are omitted.
    ///   - The unbound argument type use the `Any` typealias `UnboundAny`.
    ///   - Non-binding¹ parameters have the form `_: UnboundAny`.
    ///   - **Value types** <A, B, C, D, E> | <T, U, V> | <W, X, Y, Z>
    ///   - **Value args**  (a, b, c, d, e) | (t, u, v) | (w, x, y, z)
    ///   - **Func types**  _ f: (Type₁, ···, Typeᵢ) -> Result
    ///   - **Func args**   (f, g, h, i, j, k, l, m, n, o)
    ///   - **Predicates**  P Q R S | p q r s
    ///
    /// ### Synonyms
    ///   - Flip, converse, crossed. We use flip.
    ///
    /// Combinators ordered by parametric complexity.
    ///
    /// ### Missing
    ///     - M     Mockingbird
    ///     - M₂    Double Mockingbird
    ///     - Km    Konstant Mocker
    ///     - Km(C) Flipped Konstant Mocker
    ///     - L     Lark
    ///     - X     β-Sage
    ///     - Y'    Sage Prime
    ///     - Y*    Mutual Sage
    ///     - Z     Strict Sage
    ///     - Ω     Iega
    ///     - θ     Theta
    ///
    ///     - Turing
    ///
    /// ### Documentation
    /// Documentation for each combinator with implementations in λ-calculus and ❭λ꞊
    public /*namespace*/ enum Aviary { }
}

extension λ.Aviary {

    // MARK: - Identity

    /// I combinator ∎ The identity function.
    ///
    /// A polymorphic unary function which evaluates to its argument.
    ///
    /// - Note: Along with K, they are the only combinators that are not a
    ///   higher-order functions.
    /// - Important: The I also stands for Idiot, though according to Smullyan,
    ///   the apparent "unimaginative" behavior of I is due to its unusually
    ///   large heart and hence it's fond of everyone. Although this famous
    ///   mathematician presents a viewpoint that is as compelling as it is
    ///   heartwarming, it is important to remember we are still talking about
    ///   parametrically polymorphic functions binding arguments for
    ///   subsequent evaluation.
    /// - Parameter x: A value.
    /// - Returns: The identity of the given value, which is the value itself.
    public static func idiot<A>(_ a: A) -> A {
        return a
    }

    // MARK: - Const

    /// K combinator ∎ The constant function.
    ///
    /// The Kestrel's response to hearing a song `b` is (a song which
    /// describes) a bird which responds with 𝑥 no matter what it
    /// hears.
    ///
    /// - Parameter x: A value.
    /// - Returns: The constant function on `𝑥`.
    public static func kestrel<A, B>(_ a: A) -> (B) -> A {
        return { _ in a }
    }

    /// Ki-combinator ∎ The stubborn function.
    ///
    /// The Kite ignores anything it hears and always responds like an
    /// Idiot (bird).
    ///
    ///     𝐾𝑖 := λ𝑎.λ𝑏.𝑏
    ///
    /// - Parameter α: A value for the kite to ignore.
    /// - Returns: The identity function.
    public static func kite<B>(_: Any) -> (B) -> B {
        return idiot
    }

    // MARK: - Map

    /// I* ∎ Function application, once removed.
    ///
    /// _Because everyone gets a participation star._
    public static func idiotOnceRemoved<A, Result>(
        _ f: @escaping (A) -> Result
    ) -> (A) -> Result {
        return { a in f(a) }
    }

    /// I** ∎ Function application, twice removed.
    ///
    /// _Because everyone gets two participation stars._
    public static func idiotTwiceRemoved<A, Result>(
        _ f: @escaping (A) -> Result)
    -> (_ a: A)
    -> (_  : Any)
    -> Result {
        return { a in { _ in f(a) } }
    }

    /// T combinator ∎ The permuting function.
    ///
    /// Thrush is the flipped identity once removed combinator.
    ///
    /// Also known as reverse application and Mr. Pipe, or Señor Pipi
    /// in Eh-spanyol, not to be confused with Spanish where it is simply
    /// referred to as `|>`.
    /// - - -
    /// ### Haskell declaration
    ///     & :: a -> (a -> b) -> b
    public static func thrush<A, Result>(
        _ a: A)
    -> (_ f: @escaping (A) -> Result)
    -> Result {
        return { ƒ in ƒ(a) }
    }

    /// V combinator ∎ The paring function
    ///
    /// vireo :: a -> b -> (a -> b -> c) -> c
    /// vireo x y f = f x y
    public static func vireo<A, B, Result>(
        _ a: A)
    -> (_ b: B)
    -> (_ f: (A) -> (B) -> Result)
    -> Result {
        return { b in { f in f(a)(b) } }
    }

    /// V* combinator ∎
    ///
    /// vireo* :: (b -> a -> b -> d) -> a -> b -> b -> d
    /// vireo* f x y z = f y x z
    public static func vireoOnceRemoved<A, B, Result>(
        _ f: @escaping (B) -> (A) -> (B) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> (_ bʹ:B)
    -> Result {
        return { a in { b in { bʹ in f(b)(a)(bʹ) } } }
    }

    /// V** combinator ∎
    ///
    /// vireo** :: (a -> c -> b -> c -> e) -> a -> b -> c -> c -> e
    /// vireo** f s t u v = f s v t u
    public static func vireoTwiceRemoved<A, B, C, Result>(
        _ f: @escaping (A) -> (C) -> (B) -> (C) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> (_ c: C)
    -> (_ cʹ:C)
    -> Result {
        return { a in { b in { c in { cʹ in f(a)(c)(b)(cʹ) } } } }
    }

    // MARK: - Flip

    /// C ∎ The flip function.
    ///
    /// Flips the argument order of a binary function.
    public static func cardinal<A, B, Result>(
        _ f: @escaping (A) -> (B) -> Result)
    -> (B) -> (A) -> Result {
        return { b in { a in f(a)(b) } }
    }

    /// Cʹ ∎ The flip prime function.
    public static func cardinalPrime<A, B, C, Result>(
        _ f: @escaping (C) -> (A) -> Result)
    -> (_ g: @escaping (B) -> C)
    -> (_ a: A)
    -> (_ b: B)
    -> Result {
        return { g in { a in { b in f(g(b))(a) } } }
    }

    /// C* ∎ Flip Once Removed.
    public static func cardinalOnceRemoved<A, B, C, Result>(
        _ f: @escaping (A) -> (C) -> (B) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> (_ c: C)
    -> Result {
        return { a in { b in { c in f(a)(c)(b) } } }
    }

    /// C** ∎ Flip Twice Removed.
    public static func cardinalTwiceRemoved<A, B, C, D, Result>(
        _ f: @escaping (A) -> (B) -> (D) -> (C) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> (_ c: C)
    -> (_ d: D)
    -> Result {
        return { a in { b in { c in { d in f(a)(b)(d)(c) } } } }
    }

    /// F combinator ∎ Thrushed flip.
    public static func finch<A, B, Result>(
        _ a: A)
    -> (_ b: B)
    -> (_ f: @escaping (B) -> (A) -> Result)
    -> Result {
        return { b in { f in f(b)(a) } }
    }

    /// F* combinator
    public static func finchOnceRemoved<A, B, C, Result>(
        _ f: @escaping (C) -> (B) -> (A) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> (_ c: C)
    -> Result {
        return { a in { b in { c in f(c)(b)(a) } } }
    }

    /// F** combinator
    public static func finchTwiceRemoved<A, B, C, D, Result>(
        _ f: @escaping (A) -> (D) -> (C) -> (B) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> (_ c: C)
    -> (_ d: D)
    -> Result {
        return { a in { b in { c in { d in f(a)(d)(c)(b) } } } }
    }

    /// R combinator
    public static func robin<A, B, Result>(
        _ a: A)
    -> (_ f: @escaping (B) -> (A) -> Result)
    -> (_ b: B)
    -> Result {
        return { f in { b in f(b)(a) } }
    }

    /// R* combinator
    public static func robinOnceRemoved<A, B, C, Result>(
        _ f: @escaping (B) -> (C) -> (A) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> (_ c: C)
    -> Result {
        return { a in { b in { c in f(b)(c)(a) } } }
    }

    /// R** combinator
    public static func robinTwiceRemoved<A, B, C, D, Result>(
        _ f: @escaping (A) -> (C) -> (D) -> (B) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> (_ c: C)
    -> (_ d: D)
    -> Result {
        return { a in { b in { c in { d in f(a)(c)(d)(b) } } } }
    }

    // MARK: - Join

    /// W combinator ∎ The join function.
    ///
    /// Flattens a binary function.
    ///
    ///     W :: (a -> a -> b) -> a -> b
    ///     W f x = f x x
    public static func warbler<A, Result>(
        _ f: @escaping (A) -> (A) -> Result
    ) -> (A) -> Result {
        return { a in f(a)(a) }
    }

    /// W1 combinator ∎ Flipped join function.
    ///
    ///     W1 :: a -> (a -> a -> b) -> b
    ///     W1 x f = f x x
    public static func worbler<A, Result>(
        _ a: A
    ) -> ((A) -> (A) -> Result) -> Result {
        return { f in f(a)(a) }
    }

    /// W* combinator ∎ Join function, once removed.
    ///
    ///     W* :: (a -> b -> b -> c) -> a -> b -> c
    ///     W* f x y = f x y y
    public static func warblerOnceRemoved<A, B, Result>(
        _ f: @escaping (A) -> (B) -> (B) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> Result {
        return { a in { b in f(a)(b)(b) } }
    }

    /// W** combinator ∎ Join function, twice removed.
    ///
    ///     W** :: (a -> b -> c -> c -> d) -> a -> b -> c -> d
    ///     W** f x y z = f x y z z
    public static func warblerTwiceRemoved<A, B, C, Result>(
        _ f: @escaping (A) -> (B) -> (C) -> (C) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> (_ c: C)
    -> Result {
        return { a in { b in { c in f(a)(b)(c)(c) } } }
    }

    /// H combinator ∎ Flipped join once removed function.
    public static func hummingbird<A, B, Result>(
        _ f: @escaping (A) -> (B) -> (A) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> Result {
        return { a in { b in f(a)(b)(a) } }
    }

    // MARK: - Composition

    /// B combinator ∎ The function composition function.
    ///
    /// Produces a function chaining the output of an inner function
    /// `g` to the input of an outer function `f`.
    ///
    /// - Parameters:
    ///     - f: The outer function.
    ///     - g: The inner function.
    /// - Returns: A function composing `f` and `g`.
    public static func bluebird<A, B, Result>(
        _ g: @escaping (B) -> Result)
    -> (_ f: @escaping (A) -> B)
    -> (_ a: A)
    -> Result {
        return { f in { a in g(f(a)) } }
    }

    ///  Bʹ combinator
    public static func bluebirdPrime<A, B, C, Result>(
        _ f: @escaping (A) -> (C) -> Result)
    -> (_ a: A)
    -> (_ g: @escaping (B) -> C)
    -> (_ b: B)
    -> Result {
        return { a in { g in { b in f(a)(g(b)) } } }
    }

    /// B₁ combinator
    public static func blackbird<A, B, C, Result>(
        _ g: @escaping (C) -> Result)
    -> (_ f: @escaping (A) -> (B) -> C)
    -> (_ a: A)
    -> (_ b: B)
    -> Result {
        return { f in { a in { b in g(f(a)(b)) } } }
    }

    /// B₂ combinator
    public static func bunting<A, B, C, D, Result>(
        _ g: @escaping (D) -> Result)
    -> (_ f: @escaping (A) -> (B) -> (C) -> D)
    -> (_ a: A)
    -> (_ b: B)
    -> (_ c: C)
    -> Result {
        return { f in { a in { b in { c in g(f(a)(b)(c)) } } } }
    }

    /// B₃ combinator
    public static func becard<A, B, C, Result>(
        _ h: @escaping (C) -> Result)
    -> (_ g: @escaping (B) -> C)
    -> (_ f: @escaping (A) -> B)
    -> (_ a: A)
    -> Result {
        return { g in { f in { a in h(g(f(a))) } } }
    }

    /// Q ∎ Reverse function composition.
    ///
    /// Queer, composes two functions by applying the first one and then
    /// the second one, passing the result of the former one as the
    /// argument of the latter.
    ///
    /// - Parameters:
    ///     - f: The outer function.
    ///     - g: The inner function.
    /// - Returns: A function that will apply `ƒ` then `g`.
    public static func queer<A, B, Result>(
        _ f: @escaping (A) -> B)
    -> (_ g: @escaping (B) -> Result)
    -> (_ a: A)
    -> Result {
        return { g in { a in g(f(a)) } }
    }

    /// Q₁ combinator ∎ Infixed function composition
    public static func quixotic<A, B, Result>(
        _ g: @escaping (B) -> Result)
    -> (_ a: A)
    -> (_ f: @escaping (A) -> B)
    -> Result {
        return { a in { f in g(f(a)) } }
    }

    /// Q₂ combinator ∎ Thrushed function composition
    public static func quizzical<A, B, Result>(
        _ a: A)
    -> (_ g: @escaping (B) -> Result)
    -> (_ f: @escaping (A) -> B)
    -> Result {
        return { g in { f in g(f(a)) } }
    }

    /// Q₃ combinator ∎ Flipped infixed function composition
    public static func quirky<A, B, Result>(
        _ f: @escaping (A) -> B)
    -> (_ a: A)
    -> (_ g: @escaping (B) -> Result)
    -> Result {
        return { a in { g in g(f(a)) } }
    }

    /// Q₄ combinator ∎ Thrushed flipped function composition
    public static func quacky<A, B, Result>(
        _ a: A)
    -> (_ f: @escaping (A) -> B)
    -> (_ g: @escaping (B) -> Result)
    -> Result {
        return { f in { g in g(f(a)) } }
    }

    // MARK: - Ap

    /// S combinator ∎ The amalgamation function or substitution operator.
    ///
    /// A ternary function which returns its first argument applied to
    /// the third, which is then applied to the result of the second
    /// argument applied to the third.
    ///
    ///     𝑆 := λ𝑎.λ𝑏.λ𝑐.𝑎 𝑐 (𝑏 𝑐)
    ///     starling :: (a -> b -> c) -> (a -> b) -> a -> c
    ///     starling f g x = f x (g x)
    ///
    /// - Note: This is Applicative's `apply` (`<*>`) on functions.
    ///
    ///     instance Applicative 𝐴 => 𝐴 ((->) a) where
    ///       ┌───╸(<*>) :: 𝐴 (b -> c) -> (𝐴 b) -> 𝐴 c
    ///       │          :: (->) a (b -> c) -> ((->) a b) -> (->) a c
    ///       ╽ starling :: (a -> b -> c) -> (a -> b) -> a -> c
    ///       = starling f g a = f a (g a)
    public static func starling<A, B, Result>(
        _ f: @escaping (A) -> (B) -> Result)
    -> (_ g: @escaping (A) -> B)
    -> (_ a: A)
    -> Result {
        return { g in { a in f(a)(g(a)) } }
    }

    public static func starlingPrime<A, B, C, Result>(
        _ f: @escaping (B) -> (C) -> Result)
    -> (_ g: @escaping (A) -> B)
    -> (_ h: @escaping (A) -> C)
    -> (_ a: A)
    -> Result {
        return { g in { h in { a in f(g(a))(h(a)) } } }
    }

    /// Φ combinator ∎ Turner's big phi, also known as the starling prime (Sʹ).
    ///
    /// This is the Applicative and Monadic's binary lift on functions.
    ///
    /// phoenix :: (b -> c -> d) -> (a -> b) -> (a -> c) -> a -> d
    /// phoenix f g h x = f (g x) (h x)
    public static func phoenix<A, B, C, Result>(
        _ f: @escaping (B) -> (C) -> Result)
    -> (_ g: @escaping (A) -> B)
    -> (_ h: @escaping (A) -> C)
    -> (_ a: A)
    -> Result {
        return { g in { h in { a in f(g(a))(h(a)) } } }
    }

    // G combinator ∎ Like the finch but better, cuz gold.
    public static func goldfinch<A, B, C, Result>(
        _ f: @escaping (B) -> (C) -> Result)
    -> (_ g: @escaping (A) -> C)
    -> (_ a: A)
    -> (_ b: B)
    -> Result {
        return { g in { a in { b in f(b)(g(a)) } } }
    }

    /// D combinator
    public static func dove<A, B, C, Result>(
        _ f: @escaping (A) -> (C) -> Result)
    -> (A)
    -> (_ g: @escaping (B) -> C)
    -> (B) -> Result {
        return { a in { g in { b in f(a)(g(b)) } } }
    }

    /// D₁ combinator
    public static func dickcissel<A, B, C, D, Result>(
        _ f: @escaping (A) -> (B) -> (D) -> Result)
    -> (A)
    -> (B)
    -> (_ g: @escaping (C) -> D)
    -> (C) -> Result {
        return { a in { b in { g in { c in f(a)(b)(g(c)) } } } }
    }

    /// D₂ combinator
    public static func dovekie<A, B, C, D, Result>(
        _ f: @escaping (C) -> (D) -> Result)
    -> (_ g: @escaping (A) -> C)
    -> (A)
    -> (_ h: @escaping (B) -> D)
    -> (B) -> Result {
        return { g in { a in { h in { b in f(g(a))(h(b)) } } } }
    }

    /// E combinator
    public static func eagle<A, B, C, D, Result>(
        _ f: @escaping (A) -> (D) -> Result)
    -> (A)
    -> (_ g: @escaping (B) -> (C) -> D)
    -> (B)
    -> (C) -> Result {
        return { a in { g in { b in { c in f(a)(g(b)(c)) } } } }
    }

    /// Ê combinator ∎ The patriotic function
    public static func baldEagle<A, B, C, D, E, F, Result>(
        _ f: @escaping (E) -> (F) -> Result)
    -> (_ g: @escaping (A) -> (B) -> E)
    -> (A)
    -> (B)
    -> (_ h: @escaping (C) -> (D) -> F)
    -> (C)
    -> (D) -> Result {
        return { g in { a in { b in { h in { c in { d in
            f(g(a)(b))(h(c)(d))
        } } } } } }
    }

    // MARK: - Recursive

    /// Y combinator ∎ The fixed-point recursion paradox.
    ///
    /// ### Haskell declaration
    ///     fix :: (a -> a) -> a
    ///
    /// - Parameter ƒ: A function which takes a parameter function and
    ///   returns a function. The returned function may recur by calling
    ///   the parameter function.
    /// - Returns: A recursive function.
    public static func sage<A, Result>(
        _ f: @escaping (@escaping (A) -> Result) -> (A) -> Result)
    -> (_ a: A)
    -> Result {
        return { a in f(sage(f))(a) }
    }

    // MARK: - J

    /// J combinator ∎ The jay.
    ///
    /// Applied in sequence, the J and Z combinators give raise to Jay-Z.
    ///
    ///     jay :: (a -> b -> b) -> a -> b -> a -> b
    ///     jay f x y z = f x (f z y)
    public static func jay<A, B>(
        _ ƒ: @escaping (A) -> (B) -> B)
    -> (_ a1: A)
    -> (_ b : B)
    -> (_ a2: A)
    -> B {
        return { a1 in { b in { a2 in ƒ(a1)(ƒ(a2)(b)) } } }
    }

    // MARK: - O

    /// O combinator
    public static func owl<A, Result>(
        _ f: @escaping (_ g: (A) -> Result) -> A)
    -> (_ g: (A) -> Result)
    -> Result {
        return { g in g(f(g)) }
    }

    // MARK: - Birds not in To Mock a Mockingbird

    /// A ∎ Function application, once removed.
    public static func applicator<A, Result>(
    _ f: @escaping (A) -> Result
    ) -> (A) -> Result {
        return { a in f(a) }
    }

    //(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
    //(.:) = (.) . (.)

    //(..:) :: (d -> e) -> (a -> b -> c -> d) -> a -> b -> c -> e
    //(..:) = (.) . (.:)

    /// Jᵃˡᵗ combinator ∎ Alternative J combinator from Joy, Rayward-Smith
    /// and Burton.
    public static func jalt<A, Result>(
    _ ƒ: @escaping (A) -> Result)
    -> (_ a: A)
    -> (_  : ·)
    -> Result {
        return { a in { _ in ƒ(a) } }
    }

    /// J combinator ∎ Alternative J combinator from Joy, Rayward-Smith
    /// and Burton.
    public static func jaltPrime<A, B, Result>(
    _ ƒ: @escaping (A) -> (B) -> Result)
    -> (_ a: A)
    -> (_ b: B)
    -> (_  : ·)
    -> Result {
        return { a in { b in { _ in ƒ(a)(b) } } }
    }

    /// Oʹ combinator ∎
    /// As seen in https://wiki.haskell.org/Pointfree#The_owl
    public static func owlPrime<A, Aꞌ, B, C>(
        _ f: @escaping (A) -> (B) -> C)
    -> (_ a: A)
    -> (_ g: @escaping (Aꞌ) -> B)
    -> (_ aꞌ: Aꞌ) -> C {
        return { a in { g in { aꞌ in f(a)(g(aꞌ)) } } }
        //return (curry(◦)(curry(•)(curry(◦))))
        //return curry(◦)(curry(•))(curry(◦))

        /// '(          (_) -> (_) -> _) -> (_) -> (          (_) -> _) -> (_) -> _'
        /// '(@escaping (_) -> (_) -> _) -> (_) -> (@escaping (_) -> _) -> (_) -> _'
        ///

        ///    '(@e (_) ->      _, @e (_) -> _) -> (_) -> _'
        ///       '((_) -> (@e (_) -> _, @e (_) ->      _)) -> (_) -> (_) -> _'
        /// to '(@e (_) ->     (_) -> _) -> (_) -> (@e (_)  ->  _) -> (_) -> _'

        //{ b in { c in { d in a(b)(c(d)) } } }
        ///Cannot convert return expression of type
        ///    '((_) -> (@escaping (_) -> _, @escaping (_) -> _)) -> (_) -> (_) -> _'
        /// to ' (_) -> (@escaping (_) -> _)     ->    (_) -> _'
    }

    // MARK: ψ

    /// ψ combinator ∎ Applies the function on its right to both its arguments,
    /// then applies the function on its left to the result of both prior
    /// applications.
    ///
    /// The `on` ihgher-order function.
    public static func psi<A, B, C>(
        _ f: @escaping (B) -> (B) -> C)
    -> (_ g: @escaping (A) -> B)
    -> (A) -> (A) -> C {
        return { g in { a in { aʹ in f(g(a))(g(aʹ)) } } }
    }

    // MARK: ?

    /// Applies a function until the predicate evaluates to true.
    public static func until<A>(
        _ p: @escaping (A) -> Bool)
    -> (_ f: @escaping (A) -> A)
    -> (_ a: A)
    -> A {
        return { f in { a in p(a) ? a : until(p)(f)(f(a)) } }
    }
}
