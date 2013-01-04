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
    {ok, [[CfgFile]]} = init:get_argument(cfg),
    load_config(CfgFile),
    start_log(),
    %[application:start(App) || App <- []],
    template_sup:start_link().

stop(_State) ->
    ok.

%% ===================================================================
%% Application callbacks
%% ===================================================================
%% @doc Save config to app environment
load_config(CfgFile) ->
    {ok, Cfg} = file:consult(CfgFile),
    [application:set_env(template, Key, Val) || {Key, Val} <- Cfg].

%% @doc Start logging
start_log() ->
    application:start(lager).
