task2("", "").

process_character(Current_Char, {last_alpha: L1, so_far: A}, {last_alpha: L2, so_far: R}) :-
  number_string(Current_Offset, [Current_Char]), !, Output_Char is L1 + Current_Offset, A = [Output_Char | R], L2 = L1 ;
  A = [Current_Char | R], L2 = Current_Char.

task2(Input, Result) :-
  string_codes(Input, Input_Codes),
  Input_Codes = [Input_First|_],
  is_alpha(Input_First), foldl(process_character, Input_Codes, {last_alpha: NULL, so_far: Result_Codes}, {last_alpha: _Whatever, so_far: []}),
  string_codes(Result, Result_Codes).
