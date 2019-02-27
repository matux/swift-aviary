import Swift

/// Allows a nonescaping closure to temporarily be used as if it were allowed
/// to escape.
///
/// You can use this function to call an API that takes an escaping closure in
/// a way that doesn't allow the closure to escape in practice. The examples
/// below demonstrate how to use `nonescaping(_:do:)` in
/// conjunction with two common APIs that use escaping closures: lazy
/// collection views and asynchronous operations.
///
/// The following code declares an `allValues(in:match:)` function that checks
/// whether all the elements in an array match a predicate. The function won't
/// compile as written, because a lazy collection's `filter(_:)` method
/// requires an escaping closure. The lazy collection isn't persisted, so the
/// `predicate` closure won't actually escape the body of the function;
/// nevertheless, it can't be used in this way.
///
///     func allValues(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
///         return array.lazy.filter { !predicate($0) }.isEmpty
///     }
///     // error: closure use of non-escaping parameter 'predicate'...
///
/// `nonescaping(_:do:)` provides a temporarily escapable copy of
/// `predicate` that _can_ be used in a call to the lazy view's `filter(_:)`
/// method. The second version of `allValues(in:match:)` compiles without
/// error, with the compiler guaranteeing that the `escapablePredicate`
/// closure doesn't last beyond the call to `nonescaping(_:do:)`.
///
///     func allValues(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
///         return nonescaping(predicate) { escapablePredicate in
///             array.lazy.filter { !escapablePredicate($0) }.isEmpty
///         }
///     }
///
/// Asynchronous calls are another type of API that typically escape their
/// closure arguments. The following code declares a
/// `perform(_:simultaneouslyWith:)` function that uses a dispatch queue to
/// execute two closures concurrently.
///
///     func perform(_ f: () -> Void, simultaneouslyWith g: () -> Void) {
///         let queue = DispatchQueue(label: "perform", attributes: .concurrent)
///         queue.async(execute: f)
///         queue.async(execute: g)
///         queue.sync(flags: .barrier) {}
///     }
///     // error: passing non-escaping parameter 'f'...
///     // error: passing non-escaping parameter 'g'...
///
/// The `perform(_:simultaneouslyWith:)` function ends with a call to the
/// `sync(flags:execute:)` method using the `.barrier` flag, which forces the
/// function to wait until both closures have completed running before
/// returning. Even though the barrier guarantees that neither closure will
/// escape the function, the `async(execute:)` method still requires that the
/// closures passed be marked as `@escaping`, so the first version of the
/// function does not compile. To resolve these errors, you can use
/// `nonescaping(_:do:)` to get copies of `f` and `g` that can be
/// passed to `async(execute:)`.
///
///     func perform(_ f: () -> Void, simultaneouslyWith g: () -> Void) {
///         nonescaping(f) { escapableF in
///             nonescaping(g) { escapableG in
///                 let queue = DispatchQueue(label: "perform", attributes: .concurrent)
///                 queue.async(execute: escapableF)
///                 queue.async(execute: escapableG)
///                 queue.sync(flags: .barrier) {}
///             }
///         }
///     }
///
/// - Important: The escapable copy of `closure` passed to `body` is only valid
///   during the call to `nonescaping(_:do:)`. It is undefined
///   behavior for the escapable closure to be stored, referenced, or executed
///   after the function returns.
///
/// - Parameters:
///   - closure: A nonescaping closure value that is made escapable for the
///     duration of the execution of the `body` closure. If `body` has a
///     return value, that value is also used as the return value for the
///     `nonescaping(_:do:)` function.
///   - body: A closure that is executed immediately with an escapable copy of
///     `closure` as its argument.
/// - Returns: The return value, if any, of the `body` closure.
@_transparent
@_semantics("typechecker.withoutActuallyEscaping(_:do:)")
public func nonescaping<ClosureType, ResultType>(
    _ closure: ClosureType,
    do body: (_ escapingClosure: ClosureType) throws -> ResultType
) rethrows -> ResultType {
    // this thing works fine, however, the treacherous diagnostics engine may
    // try to throw you off the path straight into a cliff if there's a
    // compilation issue. On the bright side, code may now look more like code
    //  and less like a Hunter S. Thompson's novel, plus Xcode coloring works
    //  better with this somehow... Sometimes.

    // This implementation is never used, since calls to
    // `nonescaping(_:do:)` are resolved as a special case by
    // the type checker.
    fatalError("""
        nonescaping got used since the call wasn't resolved
        as a special case by the type checker.
        """)
}
