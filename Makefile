
all:
	./rebar compile

deps:
	./rebar get-deps
	./rebar compile

run:
	ERL_LIBS=apps:deps erl +K true -sname template -s template_app
