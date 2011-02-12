%%
%% file: zm_auth.erl
%% desc: OTP for user authentication logic
%%
-module(zm_auth).
-author('Hisham Ismail <mhishami@gmail.com>').

-behaviour(gen_server).
-include_lib("eunit/include/eunit.hrl").
-include("records.hrl").

-define(SERVER, ?MODULE).
-define(RETRY, 3).

-export([get_user/1, create_user/2]).

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% Client exports
-export([echo/1, stop/0]).

%% server state record
-record(state, {}).

echo(Data) ->
    gen_server:call(?SERVER, {echo, Data}).

get_user(Username) ->
    gen_server:call(?SERVER, {get_user, Username}).

create_user(Username, Password) ->
    gen_server:call(?SERVER, {create_user, Username, Password}).

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
start_link() -> 
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%% ----------------------------------------------------------------------------
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason} 
%% @doc Starts the server
%%
init([]) -> 
    io:format("~p starting...~n", [?MODULE]),
    {ok, #state{}}.

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

handle_call({get_user, Username}, _From, State) ->
    Reply = case zm_db:find("user", [{username, Username}]) of
                {ok, []}     -> {error, no_such_user};
                {ok, [User]} -> {ok, User}
            end,
    {reply, Reply, State};

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

