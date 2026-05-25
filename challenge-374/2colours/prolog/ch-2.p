digit_RLE_number(Digit-Count, Number) :-
  length(Digits, Count),
  maplist(=(Digit), Digits),
  string_chars(Digits_Str, Digits),
  number_string(Number, Digits_Str).

task(Str, Output) :-
  string_chars(Str, Digits),
  clumped(Digits, Digits_RLE),
  maplist(digit_RLE_number, Digits_RLE, Numbers),
  max_list(Numbers, Output).
