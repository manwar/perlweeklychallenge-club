-module(ch_1).

-export([start/0, common_word_handler/0, input_pusher/1]).

count_common_words( [WL1, WL2] ) ->
    T1 = ets:new(t1, []),
    T2 = ets:new(t2, []),
    
    [ ets:update_counter(T1, Elem, {2, 1}, {Elem, 0}) || Elem <- WL1 ],
    [ ets:update_counter(T2, Elem, {2, 1}, {Elem, 0}) || Elem <- WL2 ],

    FilterFunc = fun(X) -> element(2, X) =:= 1 end,
    MapFunc = fun(X) -> element(1, X) end,
    L1 = lists:map( MapFunc, 
		    lists:filter( FilterFunc, ets:tab2list(T1) )),
    L2 = lists:map( MapFunc, 
		    lists:filter( FilterFunc, ets:tab2list(T2) )),

    sets:size( sets:intersection( 
		 [
		  sets:from_list(L1),
		  sets:from_list(L2)
		 ] )
	     ).

common_word_handler() ->
    receive
        {words, Caller_PID, Words} ->
	    Common_Count = count_common_words(Words),
	    Caller_PID ! {counted, Common_Count},
	    common_word_handler();
	finished ->
	    io:format("Done~n", [])
    end.

input_pusher( [] ) ->
    cwords ! finished;
input_pusher( [WLs|More] ) ->
    io:format("pusher ~p~n", [WLs]),
    cwords ! {words, self(), WLs},
    receive
        {counted, N} ->
	    io:format("counted ~p~n", [N])
    end,
    input_pusher( More ).

start() ->
    register( cwords, spawn(ch_1, common_word_handler, [])),
    spawn(ch_1, input_pusher, [
			       [
				[
				 ["Perl", "is", "my", "friend"],
				 ["Perl", "and", "Raku", "are", "friend"]
				],
				[
				 ["Perl", "and", "Python", "are", "very", "similar"],
				 ["Python", "is", "top", "in", "guest", "languages"]
				],
				[
				 ["Perl", "is", "imperative", "Lisp", "is", "functional"],
				 ["Crystal", "is", "similar", "to", "Ruby"]
				]
			       ]
			      ]
	 ).
