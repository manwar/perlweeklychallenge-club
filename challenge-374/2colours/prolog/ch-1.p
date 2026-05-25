:- use_module(library(dcg/basics)).

contains_vowel_substring(VS) --> string(_), vowel_substring(VS), remainder(_).

vowel_substring(VS) --> vowel_substring([0'a, 0'e, 0'i, 0'o, 0'u], VS_Codes), { string_codes(VS, VS_Codes) }.

vowel_substring(Still_Needed, [Vowel_Code|VS_Rest]) --> vowel(Vowel_Code, Still_Needed, After_Needed), vowel_substring(After_Needed, VS_Rest).
vowel_substring([], []) --> [].

vowel(VC, Needed_Before, Needed_After) --> nonblank(VC), {
  to_lower(VC, VC_Lower),
  ord_memberchk(VC_Lower, [0'a, 0'e, 0'i, 0'o, 0'u]),
  ord_del_element(Needed_Before, VC_Lower, Needed_After)
  }.

task(Str, Output) :-
  string_codes(Str, Str_Codes),
  findall(S, phrase(contains_vowel_substring(S), Str_Codes), Output).
