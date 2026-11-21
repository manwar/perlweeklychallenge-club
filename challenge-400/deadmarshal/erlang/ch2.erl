-module(ch2).
-export([minimum_genetic_mutation/3]).
-include_lib("eunit/include/eunit.hrl").

-spec minimum_genetic_mutation(Start,End,Bank) -> R when
    Start :: string(),
    End :: string(),
    Bank :: [string()],
    R :: integer().
minimum_genetic_mutation(Gene,Gene,_Bank) -> 0;
minimum_genetic_mutation(Start,End,Bank) -> 
  Valid = sets:from_list(Bank),
  case sets:is_element(End,Valid) of
    false -> -1;
    true -> bfs([Start],sets:del_element(Start,Valid),End,0)
  end.

-spec bfs(Frontier,Unvisited,End,Steps) -> R when
    Frontier :: [string()],
    Unvisited :: sets:set(string()),
    End :: string(),
    Steps :: non_neg_integer(),
    R :: integer().
bfs([],_Unvisited,_End,_Steps) -> -1;
bfs(Frontier,Unvisited,End,Steps) -> 
  Next = lists:usort([M || Gene <- Frontier,
			   M <- mutations(Gene),
			   sets:is_element(M,Unvisited)]),
  case lists:member(End,Next) of
    true -> Steps + 1;
    false -> bfs(Next,
		 sets:subtract(Unvisited,sets:from_list(Next)),
		 End,
		 Steps+1)
  end.

-spec mutations(Gene) -> R when
    Gene :: string(),
    R :: [Gene].
mutations(Gene) ->
  [Prefix ++ [C|Suffix] ||
    I <- lists:seq(0,length(Gene)-1),
    {Prefix,[Old|Suffix]} <- [lists:split(I,Gene)],
    C <- "ACGT",
    C =/= Old].

-ifdef(TEST).
minimum_genetic_mutation_test_() ->
  [
   {"Example 1",
    ?_assertEqual(-1, 
		  minimum_genetic_mutation("AACCGGTT","AACCGGTA",
					   ["AACCGCTA","AAACGGTA"]))},
   {"Example 2",
    ?_assertEqual(2, 
		  minimum_genetic_mutation("AACCGGTT","AACCGGAA",
					   ["AACCGGTA","AACCGGAA",
					    "AACCGCTA","AACCCTAA",
					    "AACCGTAA"]))},
   {"Example 3",
    ?_assertEqual(-1,minimum_genetic_mutation("AAAAAAAA","AAAAACCC",
					      ["CAAAAAAA","CCAAAAAA",
					       "AAAAAAAC"]))},
   {"Example 4",
    ?_assertEqual(7,minimum_genetic_mutation("GAAAAAAA","GCCCCCCC",
					     ["GCAAAAAA","GCCAAAAA", 
					      "GCCCAAAA","GCCCCAAA",
					      "GCCCCCAA","GCCCCCCA", 
					      "GCCCCCCC"]))},
   {"Example 5",
    ?_assertEqual(0,minimum_genetic_mutation("AACCGGTT", 
					     "AACCGGTT",
					     ["AACCGGTA"]))}
  ].
-endif.

