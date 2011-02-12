%%
%% file: db.erl
%% desc: OTP for connecting to MongoDB
%%
-module(db).
-author('Hisham Ismail <mhishami@gmail.com>').

-behaviour(gen_server).
-include_lib("eunit/include/eunit.hrl").
-include("records.hrl").

-define(SERVER, ?MODULE).
-define(RETRY, 3).

-export([save/2, find/1, find/2, find/3, update/3, upsert/3, delete/2]).

-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% Client exports
-export([echo/1, stop/0]).

%% server state record
-record(state, {pool}).

echo(Data) ->
    gen_server:call(?SERVER, {echo, Data}).

save(Coll, Docs) ->
    gen_server:call(?SERVER, {save, Coll, Docs}).

find(Coll) ->
    gen_server:call(?SERVER, {find, Coll}).

find(Coll, Selector) ->
    gen_server:call(?SERVER, {find, Coll, Selector}).

find(Coll, Selector, Options) ->
    gen_server:call(?SERVER, {find, Coll, Selector, Options}).

update(Coll, Selector, Docs) ->
    gen_server:call(?SERVER, {update, Coll, Selector, Docs}).

upsert(Coll, Selector, Docs) ->
    gen_server:call(?SERVER, {upsert, Coll, Selector, Docs}).

delete(Coll, Selector) ->
    gen_server:call(?SERVER, {delete, Coll, Selector}).

%% @spec stop() -> ok|{error, Error}
%%
%% @doc Stop authentication services
%%
stop() ->
    gen_server:cast(?SERVER, stop).

%% ============================================================================
%% Callback functions
%% ============================================================================

%% ----------------------------------------------------------------------------
%%
%% @spec start_link() -> {ok, Pid} |
%%                       ignore |
%%                       {error, Error}
%%
%% @doc Starts the server
%%
start_link(Args) -> 
    gen_server:start_link({local, ?SERVER}, ?MODULE, Args, []).

%% ----------------------------------------------------------------------------
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason} 
%% @doc Starts the server
%%
init(Args) -> 
    io:format("~p starting with pool name ~p...~n", [?MODULE, Args]),
    {ok, #state{pool=Args}}.

%% ----------------------------------------------------------------------------
%%
%% @spec handle_call(Request, Form, State) -> {reply, Reply, State} |
%%                                            {reply, Reply, State, Timeout} |
%%                                            {noreply, State} |
%%                                            {noreply, State, Timeout } |
%%                                            {stop, Reason, Reply, State} |
%%                                            {stop, Reason, State}
%%
%% @doc Handles synchronous message
%%
handle_call({echo, Data}, _From, State) ->
    {reply, {ok, Data}, State};

handle_call({save, Coll, Docs}, _From, State) ->
    {reply, {ok, emongo:insert(State#state.pool, Coll, Docs)}, State};

handle_call({find, Coll}, _From, State) ->
    {reply, {ok, emongo:find(State#state.pool, Coll)}, State};

handle_call({find, Coll, Selector}, _From, State) ->
    {reply, {ok, emongo:find(State#state.pool, Coll, Selector)}, State};

handle_call({find, Coll, Selector, Options}, _From, State) ->
    {reply, {ok, emongo:find(State#state.pool, Coll, Selector, Options)}, State};

handle_call({update, Coll, Selector, Docs}, _From, State) ->
    {reply, {ok, emongo:update(State#state.pool, Coll, Selector, Docs, false)}, State};

handle_call({upsert, Coll, Selector, Docs}, _From, State) ->
    {reply, {ok, emongo:update(State#state.pool, Coll, Selector, Docs, true)}, State};

handle_call({delete, Coll, Selector}, _From, State) ->
    {reply, {ok, emongo:delete(State#state.pool, Coll, Selector)}, State};

handle_call(_Request, _From, State) -> 
    {reply, {error, not_implemented}, State}.

%% ----------------------------------------------------------------------------
%%
%% @spec handle_cast(Msg, State) -> {noreply, NewState} |
%%                                  {noreply, NewState, Timeout} |
%%                                  {stop, Reason, NewState}
%%
%% @doc Handles asynchronous message
%%
handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.

%% ----------------------------------------------------------------------------
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
%%
%% @doc Handles infomative message
%%
handle_info(_Info, State) -> {noreply, State}.

%% ----------------------------------------------------------------------------
%%
%% @spec terminate(Reason, State) -> void()
%% @doc Handles cleanup routine prior to exit
%%
terminate(_Reason, _State) -> ok.

%% ----------------------------------------------------------------------------
%% 
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @doc Handles code/module replacement
%%
code_change(_OldVsn, State, _Extra) -> {ok, State}.

%% ============================================================================
%% Private functions
%%


%% ============================================================================
%% Test Cases
%%

validator_svc_test_() -> [

    ?_assert("foo" =:= string:to_lower("Foo"))
].

