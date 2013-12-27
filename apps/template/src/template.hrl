%% tmp debug, tests
-define(D(Term), io:format(user, "~s:~w ~240p\n", [?FILE, ?LINE, Term])).
-define(D(Fmt, Args), io:format(user, "~s:~w "++Fmt++"\n", [?FILE, ?LINE | Args])).

-compile([{parse_transform, lager_transform}]).
-define(DEBUG, lager:debug).
-define(INFO, lager:info).
-define(ERROR, lager:error).
