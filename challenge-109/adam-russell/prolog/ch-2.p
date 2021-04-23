/*
 You are given four squares as below with numbers named a,b,c,d,e,f,g.
 to place the given unique numbers in the square box so that sum of 
 numbers in each box is the same. 
               (1)                    (3)
        +--------------+      +--------------+
        ¦              ¦      ¦              ¦
        ¦      a       ¦      ¦      e       ¦
        ¦              ¦ (2)  ¦              ¦  (4)
        ¦          +---+------+---+      +---+---------+
        ¦          ¦   ¦      ¦   ¦      ¦   ¦         ¦
        ¦          ¦ b ¦      ¦ d ¦      ¦ f ¦         ¦
        ¦          ¦   ¦      ¦   ¦      ¦   ¦         ¦
        ¦          ¦   ¦      ¦   ¦      ¦   ¦         ¦
        +----------+---+      +---+------+---+         ¦
                   ¦       c      ¦      ¦      g      ¦
                   ¦              ¦      ¦             ¦
                   ¦              ¦      ¦             ¦
                   +--------------+      +-------------+
*/

:-initialization(main).

all_unique(_, []).
all_unique(L, [V|T]) :-
    fd_exactly(1, L, V),
    all_unique(L, T).

sums_in_squares_naive(Numbers, [A, B, C, D, E, F, G]):-  
    member(A, Numbers), 
    member(B, Numbers),
    member(C, Numbers),
    member(D, Numbers),
    member(E, Numbers),
    member(F, Numbers),
    member(G, Numbers),
    \+ (A == B; A == C; A == D; A == E; A == F; A == G),
    \+ (B == A; B == C; B == D; B == E; B == F; B == G),
    \+ (C == A; C == B; C == D; C == E; C == F; C == G),
    \+ (D == A; D == B; D == C; D == E; D == F; D == G),
    \+ (E == A; E == B; E == C; E == D; E == F; E == G),
    \+ (F == A; F == B; F == C; F == D; F == E; F == G),
    \+ (G == A; G == B; G == C; G == D; G == E; G == F),
    Box1 is A + B,
    Box2 is B + C + D,
    Box3 is D + E + F,
    Box4 is F + G,
    Box1 == Box2,
    Box2 == Box3,
    Box3 == Box4.

sums_in_squares_fd(Numbers, [A, B, C, D, E, F, G]):-  
    fd_domain([A, B, C, D, E, F, G], Numbers),
    all_unique([A, B, C, D, E, F, G], Numbers),
    Box1 = A + B,
    Box2 = B + C + D,
    Box3 = D + E + F,
    Box4 = F + G,
    Box1 #= Box2,
    Box2 #= Box3,
    Box3 #= Box4,
    fd_labeling([A, B, C, D, E, F, G]).
    
main:-
    setof(S, sums_in_squares_fd([1,2,3,4,5,6,7], S), Squares),
    write(Squares).