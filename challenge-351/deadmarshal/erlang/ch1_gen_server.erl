-module(ch1_gen_server).
-behavior(gen_server).

-export([start/0,start_link/0,stop/1,special_average/2]).
-export([init/1,handle_call/3,handle_cast/2,
  handle_info/2,terminate/2,code_change/3]).

%% Client API:
start() ->
  gen_server:start(?MODULE,[],[]).

start_link() ->
  gen_server:start_link(?MODULE,[],[]).

stop(Pid) ->
  gen_server:call(Pid,terminate).

special_average(Pid,L) ->
  gen_server:call(Pid,{special_average,L}).

%% callbacks:

init(_Args) ->
  {ok,[]}.

handle_call({special_average,L},_From,State) -> 
  {reply,special_average_private(L),State};
handle_call(terminate,_From,State) ->
  {stop,normal,ok,State}.

handle_cast(_Request,State) -> 
  {noreply,State}.

handle_info(Info,_State) -> 
  io:format("Unexpected message: ~p~n",[Info]),
  {noreply,[]}.

terminate(Reason,_State) ->
  ok.

code_change(_OldVsn,State,_Extra) ->
  {ok,State}.

%% Private:
-spec special_average_private([term()]) -> non_neg_integer().
special_average_private([_]) -> 0;
special_average_private(L) ->
  S = lists:sort(L),
  Sub = lists:sublist(S,2,length(L)-2),
  lists:sum(Sub) div length(Sub).
