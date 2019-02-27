// The role of a manager is not to control and direct what you do, but to
// provide context so you can make the appropriate decisions to create the
// best possible solution to the problems surrounding said context.
import Swift

extension λ {

    /// These are some of the combinators known to be operational to this day,
    /// identified patterns that repeat enough to become candidates for
    /// efficient abstraction and then find a way to into our every day life.
    ///
    /// If you happen to stumble upon any of these combinators, call the Turing
    /// police immediately and a group of Imperatives armed with state machines
    /// and a bazooka will be dispatched to your location at once.
    ///
    /// - Note: Due to budget concerns, these functions had to be documented
    ///   by a non-functional programmer. Refer to the functions interdefined
    ///   in the body for a detailed explanation. Alternatively, you may close
    ///   this project and go do something productive for once.
    public /*namespace*/ enum Pervasives {

        /// A function that calls other functions.
        static func `$` <A, B>()
        -> (@escaping (A) -> B)
        -> (A) -> B {
            return curry(<|)
        }

        /// A function that doesn't do anything.
        static func identity<A>() -> (A) -> A {
            return id
        }

        /// A function that makes functions that ignore arguments.
        static func always<A>() -> (A) -> (·) -> A {
            return const
        }

        /// A function that makes functions that don't do anything.
        static func never<B>() -> (·) -> (B) -> B {
            return const(id)
        }

        /// A function that makes functions that call two functions.
        static func compose<A, B, C>()
        -> (_ f: @escaping (B) -> C)
        -> (_ g: @escaping (A) -> B)
        -> (A) -> C {
            return curry(◦)
        }

        /// A function that makes functions that call two functions in reverse.
        static func chain<A, B, C>()
        -> (_ f: @escaping (A) -> B)
        -> (_ g: @escaping (B) -> C)
        -> (A) -> C {
            return curry(>>>)
        }

        /// A function that calls functions inside of functions with a function.
        static func ap <A, B, C>()
        -> (@escaping (A) -> (B) -> C)
        -> (@escaping (A) -> B)
        -> (A) -> C {
            return curry(<*>)
        }
    }
}
