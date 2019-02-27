import Swift

/// # Partial Function Application
/// _"The power of function calls... But just a part of it."_™
///
/// In Category theory, the partial application of a binary function
/// can be denoted by the isomorphism of its exponential object and its
/// curried form:
///
///     𝑝𝑎𝑝𝑝𝑙𝑦 𝑎 𝑏 𝑐 ∷ 𝐶ᴬˣᴮ × 𝐴 =̃ (𝐶ᴮ)ᴬ × 𝐴 -> 𝐶ᴮ
///
/// In the context of Computer Science, however, this represents the
/// notion of the computer scientist telling you "your dumb."
///
/// I know. Bastards.
///
/// Now that you understand the concept, let's proceed with the use
/// cases:
///
/// ### SeeAlso:
///  - [Wikipedia](https://en.wikipedia.org/wiki/Partial_application)
///  - [Rosetta Code](https://rosettacode.org/wiki/Partial_function_application)
private enum Partial { }

// MARK: - 2-ary

/// Partially apply a function of 2 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, Result>(
    _ λ: @escaping (A, B) -> Result, _ a: (A), _  : (·)
) -> (B) -> Result {
    return { b in λ(a, b) }
}

/// Partially apply a function of 2 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, Result>(
    _ λ: @escaping (A, B) -> Result, _  : (·), _ b: (B)
) -> (A) -> Result {
    return { a in λ(a, b) }
}

// MARK: - 3-ary

/// Partially apply a function of 3 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, Result>(
    _ λ: @escaping (A, B, C) -> Result, _ a: (A), _ b: (B), _  : (·)
) -> (C) -> Result {
    return { c in λ(a, b, c) }
}

/// Partially apply a function of 3 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, Result>(
    _ λ: @escaping (A, B, C) -> Result, _ a: (A), _  : (·), _ c: (C)
) -> (B) -> Result {
    return { b in λ(a, b, c) }
}

/// Partially apply a function of 3 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, Result>(
    _ λ: @escaping (A, B, C) -> Result, _ a: (A), _  : (·), _  : (·)
) -> (B, C) -> Result {
    return { b, c in λ(a, b, c) }
}

/// Partially apply a function of 3 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, Result>(
    _ λ: @escaping (A, B, C) -> Result, _  : (·), _ b: (B), _ c: (C)
) -> (A) -> Result {
    return { a in λ(a, b, c) }
}

/// Partially apply a function of 3 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, Result>(
    _ λ: @escaping (A, B, C) -> Result, _  : (·), _ b: (B), _  : (·)
) -> (A, C) -> Result {
    return { a, c in λ(a, b, c) }
}

/// Partially apply a function of 3 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, Result>(
    _ λ: @escaping (A, B, C) -> Result, _  : (·), _  : (·), _ c: (C)
) -> (A, B) -> Result {
    return { a, b in λ(a, b, c) }
}

// MARK: - 4-ary

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _ a: (A), _ b: (B), _ c: (C), _  : (·)
) -> (D) -> Result {
    return { d in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _ a: (A), _ b: (B), _  : (·), _ d: (D)
) -> (C) -> Result {
    return { c in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _ a: (A), _ b: (B), _  : (·), _  : (·)
) -> (C, D) -> Result {
    return { c, d in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _ a: (A), _  : (·), _ c: (C), _ d: (D)
) -> (B) -> Result {
    return { b in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _ a: (A), _  : (·), _ c: (C), _  : (·)
) -> (B, D) -> Result {
    return { b, d in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _ a: (A), _  : (·), _  : (·), _ d: (D)
) -> (B, C) -> Result {
    return { b, c in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _ a: (A), _  : (·), _  : (·), _  : (·)
) -> (B, C, D) -> Result {
    return { b, c, d in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _  : (·), _ b: (B), _ c: (C), _ d: (D)
) -> (A) -> Result {
    return { a in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _  : (·), _ b: (B), _ c: (C), _  : (·)
) -> (A, D) -> Result {
    return { a, d in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _  : (·), _ b: (B), _  : (·), _ d: (D)
) -> (A, C) -> Result {
    return { a, c in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _  : (·), _ b: (B), _  : (·), _  : (·)
) -> (A, C, D) -> Result {
    return { a, c, d in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _  : (·), _  : (·), _ c: (C), _ d: (D)
) -> (A, B) -> Result {
    return { a, b in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _  : (·), _  : (·), _ c: (C), _  : (·)
) -> (A, B, D) -> Result {
    return { a, b, d in λ(a, b, c, d) }
}

/// Partially apply a function of 4 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, Result>(
    _ λ: @escaping (A, B, C, D) -> Result, _  : (·), _  : (·), _  : (·), _ d: (D)
) -> (A, B, C) -> Result {
    return { a, b, c in λ(a, b, c, d) }
}

// MARK: - 5-ary

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _ b: (B), _ c: (C), _ d: (D), _  : (·)
) -> (E) -> Result {
    return { e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _ b: (B), _ c: (C), _  : (·), _ e: (E)
) -> (D) -> Result {
    return { d in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _ b: (B), _ c: (C), _  : (·), _  : (·)
) -> (D, E) -> Result {
    return { d, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _ b: (B), _  : (·), _ d: (D), _ e: (E)
) -> (C) -> Result {
    return { c in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _ b: (B), _  : (·), _ d: (D), _  : (·)
) -> (C, E) -> Result {
    return { c, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _ b: (B), _  : (·), _  : (·), _ e: (E)
) -> (C, D) -> Result {
    return { c, d in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _ b: (B), _  : (·), _  : (·), _  : (·)
) -> (C, D, E) -> Result {
    return { c, d, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _  : (·), _ c: (C), _ d: (D), _ e: (E)
) -> (B) -> Result {
    return { b in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _  : (·), _ c: (C), _ d: (D), _  : (·)
) -> (B, E) -> Result {
    return { b, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _  : (·), _ c: (C), _  : (·), _ e: (E)
) -> (B, D) -> Result {
    return { b, d in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _  : (·), _ c: (C), _  : (·), _  : (·)
) -> (B, D, E) -> Result {
    return { b, d, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _  : (·), _  : (·), _ d: (D), _ e: (E)
) -> (B, C) -> Result {
    return { b, c in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _  : (·), _  : (·), _ d: (D), _  : (·)
) -> (B, C, E) -> Result {
    return { b, c, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _  : (·), _  : (·), _  : (·), _ e: (E)
) -> (B, C, D) -> Result {
    return { b, c, d in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _ a: (A), _  : (·), _  : (·), _  : (·), _  : (·)
) -> (B, C, D, E) -> Result {
    return { b, c, d, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _ b: (B), _ c: (C), _ d: (D), _ e: (E)
) -> (A) -> Result {
    return { a in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _ b: (B), _ c: (C), _ d: (D), _  : (·)
) -> (A, E) -> Result {
    return { a, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _ b: (B), _ c: (C), _  : (·), _ e: (E)
) -> (A, D) -> Result {
    return { a, d in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _ b: (B), _ c: (C), _  : (·), _  : (·)
) -> (A, D, E) -> Result {
    return { a, d, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _ b: (B), _  : (·), _ d: (D), _ e: (E)
) -> (A, C) -> Result {
    return { a, c in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _ b: (B), _  : (·), _ d: (D), _  : (·)
) -> (A, C, E) -> Result {
    return { a, c, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _ b: (B), _  : (·), _  : (·), _ e: (E)
) -> (A, C, D) -> Result {
    return { a, c, d in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _ b: (B), _  : (·), _  : (·), _  : (·)
) -> (A, C, D, E) -> Result {
    return { a, c, d, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _  : (·), _ c: (C), _ d: (D), _ e: (E)
) -> (A, B) -> Result {
    return { a, b in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _  : (·), _ c: (C), _ d: (D), _  : (·)
) -> (A, B, E) -> Result {
    return { a, b, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _  : (·), _ c: (C), _  : (·), _ e: (E)
) -> (A, B, D) -> Result {
    return { a, b, d in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _  : (·), _ c: (C), _  : (·), _  : (·)
) -> (A, B, D, E) -> Result {
    return { a, b, d, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _  : (·), _  : (·), _ d: (D), _ e: (E)
) -> (A, B, C) -> Result {
    return { a, b, c in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _  : (·), _  : (·), _ d: (D), _  : (·)
) -> (A, B, C, E) -> Result {
    return { a, b, c, e in λ(a, b, c, d, e) }
}

/// Partially apply a function of 5 parameters, providing
/// some, but not all, arguments.
@inlinable
internal func partial<A, B, C, D, E, Result>(
    _ λ: @escaping (A, B, C, D, E) -> Result, _  : (·), _  : (·), _  : (·), _  : (·), _ e: (E)
) -> (A, B, C, D) -> Result {
    return { a, b, c, d in λ(a, b, c, d, e) }
}

