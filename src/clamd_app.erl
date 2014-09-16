-module(clamd_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    {ok, Connection} = application:get_env(clamd, connection),
    clamd_sup:start_link(Connection).

stop(_State) ->
    ok.
