NODE_NAME=template
RUN_ERL_LOG_MAXSIZE=10485760
RUN_ERL_DIR=priv/run_erl/
REBAR=@./rebar

.PHONY: deps

all: compile

compile:
	$(REBAR) compile skip_deps=true

deps:
	$(REBAR) get-deps
	$(REBAR) compile

clean:
	$(REBAR) clean
	@rm -f erl_crash.dump

run:
	@ERL_LIBS=apps:deps erl +K true -config priv/apps -sname $(NODE_NAME) -s template_app

start:
	@mkdir -p $(RUN_ERL_DIR)
	@run_erl -daemon $(RUN_ERL_DIR) $(RUN_ERL_DIR) "exec make run"

attach:
	@to_erl $(RUN_ERL_DIR)

stop:
	@echo "init:stop()." | to_erl $(RUN_ERL_DIR) 2>/dev/null
