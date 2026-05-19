% TASK 1

% You are given a string.

% Write a script to return all possible vowel 
% substrings in the given string. A vowel substring 
% is a substring that only consists of vowels and 
% has all five vowels present in it.

use_module(library(lists)).

is_ok(Str) :-
    string_chars(Str, L),
    list_to_set(L, S),
    string_chars("aeiou", Vowels),
    subset(Vowels, S),
    subset(S, Vowels).

count_vowels(X, Full) :-
    sub_string(Full, _, _, _, X),
    is_ok(X).

% Run the test suite:
% swipl -g run_tests -t halt ch-1.pl

:- begin_tests(count_vowels).

test(1) :- 
    findall(X, count_vowels(X, "aeiou"), Sols),
    Sols == ["aeiou"].

test(2) :- 
    findall(X, count_vowels(X, "aaeeeiioouu"), Sols),
    msort(Sols, SortSols),
    SortSols == ["aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu"].

test(3) :- 
    findall(X, count_vowels(X, "aeiouuaxaeiou"), Sols),
    msort(Sols, SortSols),
    SortSols == ["aeiou", "aeiou", "aeiouu", "aeiouua", "eiouua"].

test(4) :- 
    findall(X, count_vowels(X, "uaeiou"), Sols),
    msort(Sols, SortSols),
    SortSols == ["aeiou", "uaeio", "uaeiou"].

test(5) :- 
    findall(X, count_vowels(X, "aeioaeioa"), Sols),
    msort(Sols, SortSols),
    SortSols == [].

:- end_tests(count_vowels).