-module(ch1).
-export([permute/2]).
-include_lib("eunit/include/eunit.hrl").

-spec permute(L,Perms) -> R when
    L :: [term()],
    Perms :: [non_neg_integer()],
    R :: [term()].
permute(L,Perms) ->
  {_,Sorted} = lists:unzip(lists:sort(lists:zip(Perms,L))),
  Sorted.

-spec reorder_notes(Tuple) -> R when
    Tuple :: {string(),[string()],[non_neg_integer()]},
    R :: string().
reorder_notes({Composer,Notes,Perm}) ->
  Reordered = permute(Notes,Perm),
  string:uppercase(Composer) ++ " => " ++ string:join(Reordered," ").

-ifdef(TEST).
reorder_notes_test_() ->
  [
   {"Example 1",
    ?_assertEqual("BACH => D F# A B G E C",
		  reorder_notes({"Bach",
				 ["C","D","E","F#","G","A","B"],
				 [7,1,6,2,5,3,4]}))},
   {"Example 2",
    ?_assertEqual("BEETHOVEN => C G D Ab F#",
		  reorder_notes({"Beethoven",
				 ["C","D","F#","G","Ab"],
				 [1, 3, 5, 2, 4]}))},
   {"Example 3",
    ?_assertEqual("BRAHMS => F Bb Db D Ab C Eb G C",
		  reorder_notes({"Brahms",
				 ["C","Db","Eb","F","G",
				  "Ab","Bb","C","D"],
				 [9,3,7,1,8,5,2,6,4]}))},
   {"Example 4",
    ?_assertEqual("BRUCKNER => D Bb F G Eb C F#",
		  reorder_notes({"Bruckner",
				 ["G","F#","Bb","C","D","Eb","F"],
				 [4,7,2,6,1,5,3]}))},
   {"Example 5",
    ?_assertEqual("BERG => C#",reorder_notes({"Berg",
					      ["C#"],
					      [1]}))}
  ].
-endif.

