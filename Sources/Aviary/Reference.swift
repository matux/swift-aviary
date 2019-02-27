/// 
/// circa June 12, 1835, 6:34pm

/// "The purpose of abstraction is not to be vague, but to create a new
/// semantic level in which one can be absolutely precise."**
///     — [Edsger W. Dijktra](https://cl.ly/2f0971072632/notwalterwhite.png)


/// Symbol Bird                   λ Abstraction        Combinator    SKI Combinator                    SK Combinator
/// A      * Applicator           λfa.fa
/// B      Bluebird               λgfa.g(fa)           S(KS)K                                          ((S(KS))K)
/// B'     Bluebird Prime         λfagb.fa(gb)
/// B1     Blackbird              λgfab.g(fab)         BBB                                             ((S(K((S(KS))K)))((S(KS))K))
/// B2     Bunting                λgfabc.f(fabc)       B(BBB)B                                         ((S(K((S(K((S(KS))K)))((S(KS))K))))((S(KS))K))
/// B3     Becard                 λhgfa.h(g(fa))       B(BB)B                                          ((S(K((S(K((S(KS))K)))((S(KS))K))))((S(KS))K))
/// C      Cardinal               λabc.acb             S(BBS)(KK)                                      ((S((S(K((S(KS))K)))S))(KK))
/// C'     Cardinal Prime         λabcd.a(bd)c         
/// C*     Cardinal Once Removed  λabcd.abdc           BC                                              (S(K((S((S(K((S(KS))K)))S))(KK))))
/// C**    Cardinal Twice Removed λabcde.abced         BC*                                             S(K(S(K((S((S(K((S(KS))K)))S))(KK))))))
/// D      Dove                   λabcd.ab(cd)         BB                                              (S(K((S(KS))K)))
/// D1     Dickcissel             λabcde.abc(de)       B(BB)                                           (S(K(S(K((S(KS))K)))))
/// D2     Dovekie                λabcde.a(bc)(de)     BB(BB)                                          ((S(K((S(KS))K)))(S(K((S(KS))K))))
/// E      Eagle                  λabcde.ab(cde)       B(BBB)                                          (S(K((S(K((S(KS))K)))((S(KS))K))))
/// Ê      Bald Eagle             λabcdefg.a(bcd)(efg) B(BBB)(B(BBB))                                  ((S(K((S(K((S(KS))K)))((S(KS))K))))(S(K((S(K((S(KS))K)))((S(KS))K)))))
/// F      Finch                  λabc.cba             ETTET                                           ((S(K((S((SK)K))(K((S(K(S((SK)K))))K)))))((S(K((S(K((S(KS))K)))((S(KS))K))))((S(K(S((SK)K))))K)))
/// F*     Finch Once Removed     λabcd.adcb           BC*R*                                           ((S(K(S(K((S((S(K((S(KS))K)))S))(KK))))))((S(K((S((S(K((S(KS))K)))S))(KK))))(S(K((S((S(K((S(KS))K)))S))(KK))))))
/// F**    Finch Twice Removed    λabcde.abedc         BF*                                             S(K((S(K(S(K((S((S(K((S(KS))K)))S))(KK))))))((S(K((S((S(K((S(KS))K)))S))(KK))))(S(K((S((S(K((S(KS))K)))S))(KK))))))))
/// G      Goldfinch              λabcd.ad(bc)         BBC                                             ((S(K((S(KS))K)))((S((S(K((S(KS))K)))S))(KK)))
/// H      Hummingbird            λabc.abcb            BW(BC)                                          ((S(K((S(K(S((S(K((S((SK)K))((SK)K))))((S(K((S(KS))K)))((S(K(S((SK)K))))K))))))K)))(S(K((S((S(K((S(KS))K)))S))(KK)))))
/// I      Idiot                  λa.a                 SKK                                             ((SK)K)
/// I*     Idiot Once Removed     λab.ab               S(SK)                                           (S(SK))
/// I**    Idiot Twice Removed    λabc.abc
/// J      Jay                    λabcd.ab(adc)        B(BC)(W(BC(B(BBB))))                            ((S(K(S(K((S((S(K((S(KS))K)))S))(KK))))))((S((S(K((S((SK)K))((SK)K))))((S(K((S(KS))K)))((S(K(S((SK)K))))K))))(K((S(K((S((S(K((S(KS))K)))S))(KK))))(S(K((S(K((S(KS))K)))((S(KS))K))))))))
/// Jᵃˡᵗ     * Jalt
/// Jᵃˡᵗ'    * Jalt Prime
/// K      Kestrel                λab.a                K                                               K
/// Ki     Kite                   λab.b                KI                                              K((SK)K))
//  Km     Konstant Mocker        λab.bb               KM                                              K((S((SK)K))((SK)K)))
//  Km(C)  Crossed Konst. Mocker  λab.aa               C(KM)                                           (S(K(S(K((S((SK)K))((SK)K))))))K)
//  L      Lark                   λfg.f(gg)            CBM                                             ((S((S(KS))K))(K((S((SK)K))((SK)K))))
//  M      Mockingbird            λf.ff                SII                                             ((S((SK)K))((SK)K))
//  M2     Double Mockingbird     λfg.fg(fg)           BM                                              (S(K((S((SK)K))((SK)K))))
/// O      Owl                    λfg.g(fg)            SI                                              (S((SK)K))
/// O'     * Owl Prime            λabcd.ab(cd)
/// P      * Psi                  λabc.bbc(ab)(aac)
/// Q      Queer Bird             λabc.b(ac)           CB                                              ((S(K(S((S(KS))K))))K)
/// Q1     Quixotic Bird          λabc.a(cb)           BCB                                             ((S(K((S((S(K((S(KS))K)))S))(KK))))((S(KS))K))
/// Q2     Quizzical Bird         λabc.b(ca)           C(BCB)                                          ((S(K(S((S(K((S((S(K((S(KS))K)))S))(KK))))((S(KS))K)))))K)
/// Q3     Quirky Bird            λabc.c(ab)           BT                                              (S(K((S(K(S((SK)K))))K)))
/// Q4     Quacky Bird            λabc.c(ba)           F*B                                             ((S(K((S((S(K((S(KS))K)))S))(KK))))((S(K(S((S(K((S((S(K((S(KS))K)))S))(KK))))((S(KS))K)))))K))
/// R      Robin                  λabc.bca             BBT                                             ((S(K((S(KS))K)))((S(K(S((SK)K))))K))
/// R*     Robin Once Removed     λabcd.acdb           C*C*                                            ((S(K((S((S(K((S(KS))K)))S))(KK))))(S(K((S((S(K((S(KS))K)))S))(KK)))))
/// R**    Robin Twice Removed    λabcde.abdec         BR*                                             S(K((S(K((S((S(K((S(KS))K)))S))(KK))))(S(K((S((S(K((S(KS))K)))S))(KK)))))))
/// S      Starling               λabc.ac(bc)          S                                               S
/// S'     * Starling Prime       λabcd.a(bd)(cd)
/// T      Thrush                 λab.ba               CI                                              ((S(K(S((SK)K))))K)
//  U      Turing                 λfg.g(ffg)           LO                                              ((S(K(S((SK)K))))((S((SK)K))((SK)K)))
/// V      Vireo                  λabc.cab             BCT                                             ((S(K((S((S(K((S(KS))K)))S))(KK))))((S(K(S((SK)K))))K))
/// V*     Vireo Once Removed     λabcd.acbd           C*F*                                            ((S(K((S((S(K((S(KS))K)))S))(KK))))((S(K(S(K((S((S(K((S(KS))K)))S))(KK))))))((S(K((S((S(K((S(KS))K)))S))(KK))))(S(K((S((S(K((S(KS))K)))S))(KK)))))))
/// V**    Vireo Twice Removed    λabcde.abecd         BV*                                             S(K((S(K((S((S(K((S(KS))K)))S))(KK))))((S(K(S(K((S((S(K((S(KS))K)))S))(KK))))))((S(K((S((S(K((S(KS))K)))S))(KK))))(S(K((S((S(K((S(KS))K)))S))(KK)))))))))
/// W      Warbler                λfa.faa              C(BMR)                                          ((S(K(S((S(K((S((SK)K))((SK)K))))((S(K((S(KS))K)))((S(K(S((SK)K))))K))))))K)
/// W1     Converse Warbler       λaf.faa              CW                                              ((S(K(S((S(K(S((S(K((S((SK)K))((SK)K))))((S(K((S(KS))K)))((S(K(S((SK)K))))K))))))K))))K)
/// W*     Warbler Once Removed   λabc.abcc            BW                                              (S(K((S(K(S((S(K((S((SK)K))((SK)K))))((S(K((S(KS))K)))((S(K(S((SK)K))))K))))))K)))
/// W**    Warbler Twice Removed  λabcd.abcdd          B(BW)                                           S(K(S(K((S(K(S((S(K((S((SK)K))((SK)K))))((S(K((S(KS))K)))((S(K(S((SK)K))))K))))))K)))))
//  X      β-Sage                 λa.(λb.bb)(λb.a(bb))
/// Y      Sage                   λa.a(λa)             SLL           S(K(SII))(S(S(KS)K)(K(SII)))      (((SS)K)((S(K((SS)(S((SS)K)))))K)
//  Y'     * Sage Prime           λab.aba(λba.b(aba))                                                  SSK(S(K(SS(S(SSK))))K)))
//  Y*     * Mutual Sage
//  Z      * Strict Sage          λa.(λb.a(λc.bbc))(λb.f(λc.bbc))
//  Ω      * Omega                λ                    MM                                              ((S((SK)K))((SK)K))((S((SK)K))((SK)K)))
//  Θ      * Theta                λ                    YO                                              (((SS)K)((S(K((SS)(S((SS)K)))))K)(S((SK)K)))
//
// * not present in from To Mock a Mockingbird

/// Combinators.
///
/// https://en.wikipedia.org/wiki/SKI_combinator_calculus
/// https://en.wikipedia.org/wiki/B,_C,_K,_W_system
/// https://en.wikipedia.org/wiki/Fixed-point_combinator
/// https://wiki.haskell.org/Pointfree, 4. Recent discoveries: owl, swing, squish
/// Impl in Haskell: http://hackage.haskell.org/package/data-aviary-0.4.0/docs/Data-Aviary-Birds.html
/// https://github.com/fantasyland/fantasy-birds
///
///
///        Idiot :: I := λx.x
///      Kestrel :: K := λx.λy.x
///     Starling :: S := λx.λy.λz.x z (y z)
///     Bluebird :: B := λƒ.λg.λx.ƒ (g x)   => ƒ×g
///    Successor ::   := λn.λƒ.λx.ƒ (n ƒ x) => x+1
///   SuccessorB ::   := λn.λƒ.Bƒ (n ƒ)     => x+1
///     Cardinal :: C := λx.λy.λz.x z y
///      Warbler :: W := λx.λy.x y y
///      Mocking :: M := λƒ.ƒ ƒ
///       Turing :: U := λx.λy.y (x x y)
///       Thrush :: T := λxy.yx             => xʸ
///        Vireo :: V := λx.λy.λƒ.ƒ (x y)
///          Why :: Y := λg.(λx.g (x x)) (λx.g (x x))
///        Omega :: Ω := ω ω ... ∞
///
/// Common Combinators
///
///     K := λxy. x ≡ X (X (X X)) ≡ X′ X′ X′
///     S := λxyz. (x z) (y z) ≡ X (X (X (X X))) ≡ X K ≡ X′ (X′ X′) ≡ B (B (B W) C) (B B)
///     I := λx. x ≡ S K S ≡ S K K ≡ X X
///     X := λx. x S K — also called ι (iota)
///     X':= λx. x K S K
///     B := λxyz. x (y z) ≡ S (K S) K — function composition
///     C := λxyz. x z y ≡ S (S (K (S (K S) K)) S) (K K)
///     W := λxy. x y y ≡ S S (K (S K K))
///     Y := λg. (λx. g (x x)) (λx. g (x x)) ≡ S (K (S I I)) (S (S (K S) K) (K (S I I)))
///     Y':= (λxy. x y x) (λyx. y (x y x)) ≡ S S K (S (K (S S (S (S S K)))) K)
///     Θ := (λxy. y (x x y)) (λxy. y (x x y)) — called the "Turing fixed-point combinator"
///     ω := λx. x x ≡ S I I
///     Ω := ω ω
///     Ω2 := (λx. x x x) (λx. x x x)
///     A fixed point combinator is any function F for which F g ≡ g (F g) for
///     all g; examples include Y, Y′, and Θ. Since lambda calculus functions
///     cannot refer to themselves by name, fixed point combinators are needed
///     to implement recursion. For example, the factorial function can be
///     implemented using f := λgx. ISZERO x 1 (MULT x (g (PRED x))), which
///     takes a function g and a number x; if x is not zero, it is multiplied
///     by the result of g (PRED x). Defining FACTORIAL := Y f (or Y′ f or Θ f)
///     means that FACTORIAL x ≡ Y f x ≡ f (Y f) x, and so f is able to recurse
///     on itself indefinitely.
