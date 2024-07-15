-module(ch_2).

-export([start/0, strong_count_handler/0, input_pusher/1, count_strong_pairs/1]).


find_strong_pairs( Num, NumList ) ->
    StrongCheck = fun( X ) -> X < (2 * Num) end,
    length( lists:filter( StrongCheck, NumList ) ).

recur_strong_pairs( [] ) -> [];
recur_strong_pairs( [N|Rest] ) -> 
    [find_strong_pairs( N, Rest )] ++ recur_strong_pairs( Rest ).

count_strong_pairs( Nums ) ->
    UNums = lists:sort( lists:uniq(Nums) ),
    Counts = recur_strong_pairs(UNums),
    lists:sum( Counts ).

strong_count_handler() ->
    receive
        {nums, Caller_PID, Nums} ->
	    Strong_Count = count_strong_pairs(Nums),
	    Caller_PID ! {counted, Strong_Count},
	    strong_count_handler();
	finished ->
	    io:format("Done~n", [])
    end.

input_pusher( [] ) ->
    strong_ch ! finished;
input_pusher( [Nums|More] ) ->
    io:format("pusher nums ~p ", [Nums]),
    strong_ch ! {nums, self(), Nums},
    receive
        {counted, N} ->
	    io:format("counted ~p~n", [N])
    end,
    input_pusher( More ).

start() ->
    register( strong_ch, spawn(ch_2, strong_count_handler, [])),
    spawn(ch_2, input_pusher, [[
			       [1, 2, 3, 4, 5],
			       [5, 7, 1, 7]
			      ]]).
