
-module(clamd_sup).

-behaviour(supervisor).

%% API
-export([start_link/1]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%% ===================================================================
%% API functions
%% ===================================================================

start_link(Connection) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, Connection).

% start_child(Value, LeaseTime) ->
%     supervisor:start_child(?SERVER, [Value, LeaseTime]).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init(Connection) ->
    {ok, { {one_for_one, 10, 10}, [
                poolboy:child_spec(clamd_pool, [
                        {name, {local, clamd_pool}},
                        {worker_module, clamd},
                        {size, 4},
                        {max_overflow, 32}], Connection)
            ]} }.

