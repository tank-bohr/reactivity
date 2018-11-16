-module(reactivity_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).
-define(CHILD(I, Type), #{
    id       => I,
    start    => {I, start_link, []},
    restart  => permanent,
    shutdown => 5000,
    type     => Type,
    modules  => [I]
}).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    {ok, {
        #{
            strategy  => one_for_all,
            intensity => 5,
            period    => 100
        },
        [?CHILD(reactivity_cowboy_sup, supervisor)]
    }}.
