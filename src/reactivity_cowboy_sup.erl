-module(reactivity_cowboy_sup).

-export([
    start_link/0
]).

-behaviour(supervisor_bridge).

-export([
    init/1,
    terminate/2
]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor_bridge:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    {ok, Pid} = cowboy:start_clear(http,
        [{port, port()}],
        #{env => #{dispatch => dispatch()}}
    ),
    {ok, Pid, #{}}.

terminate(_Reason, _State) ->
    ok.

port() ->
    application:get_env(n2o, port, 8000).

dispatch() ->
    n2o_cowboy2:points().
