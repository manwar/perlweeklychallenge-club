-module(memoize).
-behavior(gen_server).
-export([start_link/0,stop/1,memoize/3]).
-export([init/1,terminate/2,code_change/3,
	 handle_call/3,handle_cast/2,handle_info/2]).

start_link() -> gen_server:start_link(?MODULE,[],[]).

stop(Pid) ->
  gen_server:call(Pid,terminate).

init(_) -> {ok,gb_trees:empty()}.

memoize(Pid,Fun,Args) -> gen_server:call(Pid,{Fun,Args}).

handle_call({Fun,Args},_From,State) ->
  FunSig = hash(Fun,Args),
  {Resp,NewState} = 
    case gb_trees:lookup(FunSig,State) of
      {value,Value} -> {Value,State};
      none -> 
	NewResp = apply(Fun,Args),
	SavedState = gb_trees:enter(FunSig,NewResp,State),
	{NewResp,SavedState}
    end,
  {reply,Resp,NewState};
handle_call(terminate,_From,State) -> {stop,normal,ok,State};
handle_call(_,_From,State) -> {reply,error,State}.

handle_cast(_Msg,State) -> {noreply,State}.

handle_info(_Info,State) -> {noreply,State}.

terminate(_Reason,_State) -> ok.

code_change(_OldVsn,State,_Extra) -> {ok,State}.

hash(Fun,Args) ->
  {module,Module} = erlang:fun_info(Fun,module),
  {name,Name} = erlang:fun_info(Fun,name),
  {arity,Arity} = erlang:fun_info(Fun,arity),
  erlang:md5(erlang:term_to_binary({Module,Name,Arity,Args})).

