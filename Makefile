
all:
	@./rebar compile

deps:
	@./rebar get-deps
	@./rebar compile

clean:
	@./rebar clean

run:
	ERL_LIBS=apps:deps erl +K true -sname template -s template_app

start:
	@mkdir -p log/pipe
	@run_erl -daemon log/pipe/ log "exec make run"

attach:
	@to_erl log/pipe/

stop:
	@echo "init:stop()." | to_erl log/pipe/ 2>/dev/null
