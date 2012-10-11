%% @author Kirill Trofimov <sinnus@gmail.com>
%% @copyright 2012 Kirill Trofimov
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%    http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
-module(stress_test).
-author('Kirill Trofimov <sinnus@gmail.com>').
-export([start/0]).

start() ->
    ok = application:start(sasl),
    {ok, _} = ibrowse:start(),
    N = 100,
    error_logger:info_msg("Starting stress clients~n", []),
    ok = start_stress_clients(N),
    error_logger:info_msg("~p stress clients started~n", [N]).

start_stress_clients(0) ->
    ok;

start_stress_clients(N) ->
    {ok, _} = stress_client:start_link(),
    start_stress_clients(N - 1).
