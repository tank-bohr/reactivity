-module(reactivity_index).

-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").

-export([
    main/0,
    event/1
]).

main() ->
    n2o:info(?MODULE, "Main~n", []),
    [].

event(init) ->
    nitro:insert_top(container, #h2{id=heading, body = <<"Hello">>}),
    ok;
event(Event) ->
    n2o:info(?MODULE, "Event: ~p~n", [Event]),
    ok.
