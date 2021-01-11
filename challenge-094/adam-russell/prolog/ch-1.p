/*
* You are given a list of strings S.
* Write a script to group Anagrams together  
* in any random order.
*/
:-initialization(main).

letter_factor(e, 2). 
letter_factor(t, 3). 
letter_factor(a, 5).
letter_factor(o, 7). 
letter_factor(i, 11).
letter_factor(n, 13).
letter_factor(s, 17).
letter_factor(h, 19).
letter_factor(r, 23).
letter_factor(d, 29).
letter_factor(l, 31).
letter_factor(c, 37).
letter_factor(u, 41).
letter_factor(m, 43).
letter_factor(w, 47).
letter_factor(f, 53).
letter_factor(g, 59).
letter_factor(y, 61).
letter_factor(p, 67).
letter_factor(b, 71).
letter_factor(v, 73).
letter_factor(k, 79).
letter_factor(j, 83).
letter_factor(x, 89).
letter_factor(q, 97).
letter_factor(z, 101). 

chars_product([], 1).
chars_product([H|T], Product):-
    letter_factor(H, Factor),
    chars_product(T, Product0), 
    Product is Factor * Product0.  

word_product(Word, Product):-
    atom_chars(Word, Chars),
    chars_product(Chars, Product).  

organize([]):-
    findall(Words, bagof(Word, word_product(Word-_), Words), WordsList),
    write(WordsList). 
organize([H|T]):-
    word_product(H, P),
    assertz(word_product(H-P)),
    organize(T). 

main:-
    Anagrams = [opt, bat, saw, tab, pot, top, was],
    organize(Anagrams), nl,
    halt.
