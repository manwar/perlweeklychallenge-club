
  
  sum_digits(N, Sum):-
      N < 10,
      Sum = N.
  sum_digits(N, Sum):-
      number_chars(N, [C0, C1]),
      number_chars(N0, [C0]),
      number_chars(N1, [C1]),
      Sum is N0 + N1.
      

  
  luhn(L):-
      reverse(L, [Check|T]),
      luhn(Check, T, DigitSums),
      sum_list(DigitSums, S0),
      M is (S0 + Check) mod 10, !,
      M == 0.
  
  luhn(_, [], []).
  luhn(Check, [H0, H1|T], [DigitSum|DigitSums]):-
      DS is H0 * 2,
      sum_digits(DS, Sum),
      DigitSum is Sum + H1,
      luhn(Check, T, DigitSums).
  luhn(Check, [H|T], [[DigitSum|DigitSums]]):-
      DS is H * 2,
      sum_digits(DS, Sum),
      DigitSum is Sum,
      luhn(Check, T, DigitSums).
       
 
