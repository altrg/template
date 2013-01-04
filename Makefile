NODE=template
CFG=template.cfg

APP=template_app
RE_LOG_MAXSIZE=10000000
RE_DIR=priv/run_erl/
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
	@ERL_LIBS=apps:deps erl +K true -config priv/apps -s $(APP) -sname $(NODE) -cfg $(CFG)

start:
	@mkdir -p $(RE_DIR)
	@run_erl -daemon $(RE_DIR) $(RE_DIR) "exec make run"

attach:
	@to_erl $(RE_DIR)

stop:
	@echo "init:stop()." | to_erl $(RE_DIR) 2>/dev/null
