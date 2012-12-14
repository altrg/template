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
    app_start(lager),
    %load_config(kernel),
    app_start(template).

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
    template_sup:start_link().

stop(_State) ->
    ok.

%% ===================================================================
%% Internal
%% ===================================================================
load_config(App) ->
    {ok, Conf} = file:consult("priv/"++atom_to_list(App)++".cfg"),
    [application:set_env(App, K, V) || {K, V} <- Conf].

app_start(App) ->
    application:load(App),
    load_config(App),
    application:start(App).
