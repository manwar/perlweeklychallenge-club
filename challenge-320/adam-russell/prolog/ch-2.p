
  
  char_number(C, N):-
      number_chars(N, [C]).

  
  element_sum(Numbers, ElementSum):-
      sum_list(Numbers, ElementSum).

  
  digit_sum(Numbers, DigitSum):-
  maplist(number_chars, Numbers, Characters),
  flatten(Characters, CharactersFlattened),
  maplist(char_number, CharactersFlattened, Digits),
  sum_list(Digits, DigitSum).

  
  sum_differences(Numbers, Differences):-
      element_sum(Numbers, ElementSum),
      digit_sum(Numbers, DigitSum),  
      Differences is abs(DigitSum - ElementSum).

