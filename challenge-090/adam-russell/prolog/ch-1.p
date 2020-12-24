/*
* Write a script to print nucleiobase count in the given DNA sequence. 
* Also, print the complementary sequence where Thymine (T) on one strand 
* is always facing an adenine (A) and vice versa; guanine (G) is always 
* facing a cytosine (C) and vice versa.
*/ 

:- initialization(main).

nucleotide_pair('A', 'T').
nucleotide_pair('C', 'G').

compliment([H|T], [Compliment|RestOfCompliment]):-
    var(Compliment), 
    atom_chars(A, [H]),  
    (nucleotide_pair(A, X); nucleotide_pair(X, A)),    
    atom_chars(X, [Compliment]),  
    compliment(T, RestOfCompliment).  
compliment([H|T], [Compliment|RestOfCompliment]):-
    (nucleotide_pair(A, Compliment); nucleotide_pair(Compliment, A)),    
    atom_chars(A, [H]),  
    compliment(T, RestOfCompliment).  
compliment([], _). 
compliment(_, []). 

main:-
    Sequence = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG',
    atom_chars(Sequence, SequenceChars),
    length(SequenceChars, SequenceLength),
    format("Sequence length is ~d.~n", [SequenceLength]),
    length(Compliment, SequenceLength), 
    compliment(SequenceChars, Compliment),
    atom_chars(ACompliment, Compliment),
    compliment(OriginalSequence, Compliment),
    atom_chars(AOriginalSequence, OriginalSequence),
    format("Original sequence is ~a.~n", [AOriginalSequence]),
    format("Complimentary sequence is ~a.~n", [ACompliment]),
    halt.  
