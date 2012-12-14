-module(template_app).

-behaviour(application).

%% API
-export([start/0, get_config/2]).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% API
%% ===================================================================
%% @doc Launcher for erl .. -s template_app ..
start() ->
    application:start(lager),
    application:start(template).

%% @doc Get value or default from config
-spec get_config(atom(), term()) -> term().
get_config(Par, Default) ->
    case application:get_env(template, Par) of
        undefined -> Default;
        {ok, Val} -> Val
    end.

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    {ok, Conf} = file:consult("priv/template.cfg"),
    [application:set_env(template, K, V) || {K, V} <- Conf],
    template_sup:start_link().

stop(_State) ->
    ok.
