-module(ch2).
-export([longest_absolute_path/1]).
-include_lib("eunit/include/eunit.hrl").

-spec longest_absolute_path(Fs) -> R when
    Fs :: string(),
    R :: non_neg_integer().
longest_absolute_path(Fs) ->
  Entries = [parse(L) || L <- string:split(Fs,"\n",all),L =/= ""],
  walk(Entries,#{},0).

parse(Line) ->
  Name = string:trim(Line,leading,"\t"),
  {length(Line) - length(Name),Name}.

walk([],_Lens,Best) -> Best;
walk([{Depth,Name}|Rest],Lens,Best) -> 
  Len = parent_len(Depth,Lens) + length(Name),
  IsDir = case Rest of 
	    [{NextDepth,_}|_] -> NextDepth > Depth;
	    [] -> false
	  end,
  IsFile = not IsDir andalso lists:member($.,Name),
  walk(Rest,Lens#{Depth => Len},case IsFile of 
				  true -> max(Best,Len);
				  false -> Best
				end).

parent_len(0,_Lens) -> 0;
parent_len(D,Lens) -> maps:get(D-1,Lens,0) + 1.

-ifdef(TEST).
longest_absolute_path_test_() ->
  [
   {"Example 1",
    ?_assertEqual(0,longest_absolute_path("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"))},
   {"Example 2",
    ?_assertEqual(9,longest_absolute_path("file1.txt\nfile2.ext\na.png"))},
   {"Example 3",
    ?_assertEqual(38,longest_absolute_path("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"))},
   {"Example 4",
    ?_assertEqual(14,longest_absolute_path("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"))},
   {"Example 5",
    ?_assertEqual(32,longest_absolute_path("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"))}
  ].
-endif.

