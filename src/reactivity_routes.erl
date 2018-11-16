-module(reactivity_routes).

-export([
    init/2,
    finish/2
]).

-include_lib("n2o/include/n2o.hrl").

init(State, #cx{req = Req} = Cx) ->
    #{path := Path} = Req,
    Fix = route_prefix(Path),
    n2o:info(?MODULE, "Route: ~p~n",[{Fix, Path}]),
    {ok, State, Cx#cx{path=Path, module=Fix}}.

finish(State, Ctx) ->
    {ok, State, Ctx}.

route_prefix(<<"/ws/", P/binary>>) -> route(P);
route_prefix(<<"/", P/binary>>) -> route(P);
route_prefix(P) -> route(P).

route(_) -> reactivity_index.
