/// Every functional language has an Aviary and Swift is not a functional
/// language! But now it has an Aviary! Hilarious!
///
/// _Before you very understandably close this project and never look back,
///  we'd like to thank our sponsor,_
///
/// **Functional Programming™**
///
/// _Making familiar things weird af since the 1800 or something._
///
/// Still here? Well. My friend. You are weird. Let's do this!
///
/// - - -
/// Uses
///     - Learn how computers think
///     - Learn how to think like a computer
///     - Learn how to be like a computer
///     - Become a computer.
public /*namespace*/ enum Combinator { }

public typealias ƒ = Combinator // ⌥f

public typealias λ = Combinator

/// The following anecdote is told of William James. I have been unable
/// to find any published reference to it, so it may be that I have
/// attributed it to the wrong man, or that it is apocryphal. Be that as
/// it may, because of its bull's-eye relevance to the study of programs,
/// I have retold it here.
///
/// After a lecture in Object Oriented Programming and the structure
/// of a program, William James was accosted by a little old lady.
///
/// "Your theory that the class is the centre of a program, and the
/// object is a ball which rotates around it has a very convincing ring
/// to it, Mr. James, but it's wrong. I've got a better theory," said
/// the little old lady.
///
/// "And what is that, madam?" Inquired James politely.
///
/// "That we live on a crust of monads which is on the back of a simple
/// function."
///
/// Not wishing to demolish this absurd little theory by bringing to
/// bear the Gang of Four's design patterns he had at his command, James
/// decided to gently dissuade his opponent by making her see some of
/// the inadequacies of her position.
/// "If your theory is correct, madam," he asked, "what does this function
/// stand on?"
///
/// "You're a very clever man, Mr. James, and that's a very good question,"
/// replied the little old lady, "but I have an answer to it. And it is
/// this: The first function stands on the back of a second, far simpler,
/// function, who stands directly under it."
///
/// "But what does this second function stand on?" persisted James patiently.
///
/// To this, the little old lady crowed triumphantly.
///
/// "It's no use, Mr. James – it's functions all the way down."
///
/// — On the Origins of Recursion and the Y Combinator
///     Author Unknown, 1835
///
/// - SeeAlso:
///   - https://cl.ly/5c4d6f647da8
///   - http://dspace.mit.edu/handle/1721.1/15166 · page iv
/// [gof]: https://en.wikipedia.org/wiki/Design_Patterns

// Chronicles of Raymond H. Smullyan, page 3y7832yu
//
// Oh, how can I input those weird stupid characters, Mr. Smullyan?
// Raymond: "First, young man, -you- are stupid. You are. Second, the world of
// Macintosh-"
// Young man: Mac.
// Raymond: "huh?"
// Young man: "It's not Macintosh, it's Mac now, Mr. Smullyan."
// Raymond: "..."
// Young man: Mister?
// Someone else: "I think he's asleep."
// Young man "Oh..."
// Someone else: ...
// ...
// Young man: *takes Smullyan's wallet from his back pocket.*
// Raymond: "Huh? Wh- Oh, yes, Second, the world of Macintosh offer many ways
// to enter those symbols..."
//
//  Caps-lock
//      Go to System Preferences -> Keyboard -> Input Sources
//          -> [+] -> Greek -> [λ] Greek ?? [ε] Greek - Polytonic -> Add
//          -> [✓] option "Use the Caps Lock key to switch..."
//      Back to Xcode
//          -> press Caps lock -> press l for λ
//                             -> press L for Λ
//
//  Custom input source
//      Download https://cl.ly/25d0faa63e2a
//      Copy to ~/Library/Input Sources
//      Go to System Preferences -> Keyboard -> Input Sources
//          -> [+] -> Other -> us.math.something
//      Back to Xcode
//          -> press l for λ
//          -> press L for Λ
//
//  Customize input source
//      Use my custom input source: https://cl.ly/25d0faa63e2a
//          -> press l for λ
//          -> press L for Λ
//
//  Customize your input source
//      Download Ukelele: https://goo.gl/MZYtv4
//      Use my custom input source as guide: https://cl.ly/25d0faa63e2a
//
//   Customize press & hold (req. disabling SIL
//      http://weblog.masukomi.org/2015/12/13/esperanto-press-and-hold-characters/

/// _Tales from I Didn't Feel Like Learning History So I Wrote My Own,
/// Page 1532, subsection h, episode IV._
///
/// ```⠀
/// Little is known about Curry. Unfortunately, all documentation was
/// lost in the great fire of 1826 shortly after he discovered the Y
/// combinator. It is presumed the fire started after Curry himself,
/// who was known for his pranks, drove all the computers in the
/// orphanage into a recursive frenzy, subsequently turning them on
/// fire. Interestingly enough, this led directly to the invention of
/// the "stack" which serves no other purpose than to stop the Y
/// combinator from destroying computers.
///
/// ...
///
/// Curry's first name arguably has been among the most speculated
/// things in contemporary society, but historians agree that Haskell,
/// OCaml, and Scala were the only options considered serious at the
/// time. The puzzle was finally solved when the archaeologist
/// Dr. Jones found Curry's driver's license in an excavation site.
///
/// The mystery was finally solved: F# Curry.
/// ```

// -----------

/// Links
/// -----
///
/// [To dissect a Mockingbird]: http://dkeenan.com/Lambda/
/// [Programming Languages]: http://www.angelfire.com/tx4/cus/people/index.html

/// are you excited?! No? Well. I can't blame you. It's a bunch of birds after
/// all... A pack of birds? Herd. A herd of birds! English is easy.

/// Little is known about Church. Unfortunately, all documentation had been lost
/// in the great infinite loop fire of 1826. Most historians agree, however, he was
/// a very religious man.
///
/// Church beats Turing to the punch with his λ calculus. Which isn't surprising
/// considering the superiority of Functional programming. This, in turn, marks
/// the beginning of the Infinity Wars. The Functionals vs. The Imperatives.
///
/// Turing's programming techniques end up becoming more popular because he
/// single handledly is able to put an end to World War II by creating the
/// Bombe, a machine that is capable of deciphering the Nazi's Enigma
/// cryptographic machines by running a mechanical algorithm. Not too shabby.
/// But more important than any of that, the Imperatives had won this round and
/// the Functionals weren't happy.
/// True. But. At the same time the FP guys were creating the Monad, man. The
/// Monad. That's the good stuff... Ok, we'll have to give this one to
/// imperative team.

/// "A Monad is a burrito"
/// Functional programmers love abstractions, but favorite thing in
/// the world is to treat non-functional programmers like children:
///     "A Monad is like a burrito!"
///     Every example: "Let me show you how to do 2 + 2."
///     Oh, you think you're old enough? Ok then! Let me introduce you to
///         Mr. Zygohistomorphic Prepromorphism!
///     Let's write a book to get people into lambda calculus...
///         About birds in an enchanted forest!


/// "Simplicity is a great virtue but it requires
/// hard work to achieve it and education to appreciate it.
/// And to make matters worse: complexity sells better."
///     Edsger W. Dijkstra

///  ╌───────────────────────────────────────────────────╌
///   ∎  I love functional programming, It takes smart
///     people who would otherwise be competing with me
///     and turns them into unemployable crazies.
///                            - William Morgan, 2009   ∎
///  ╌───────────────────────────────────────────────────╌



///  ╌────────────────────────────────────────────────────────────╌
///   ∎  ...I now make a living hiring functional programmers.
///                 You may consider yourselves
///                         victorious.
///                                     - William Morgan, 2016   ∎
///  ╌────────────────────────────────────────────────────────────╌

