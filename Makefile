NODE=template
CFG=template.cfg

APP=template_app
RE_LOG_MAXSIZE=10000000
RE_DIR=priv/run_erl/
REBAR=@./rebar

.PHONY: all deps

all:
	$(REBAR) compile skip_deps=true

deps:
	$(REBAR) get-deps compile

clean:
	$(REBAR) clean
	@rm -rf erl_crash.dump

run:
	@ERL_LIBS=deps erl +K true -pa ebin -config priv/apps -s $(APP) -sname $(NODE) -cfg $(CFG)

start:
	@mkdir -p $(RE_DIR)
	@run_erl -daemon $(RE_DIR) $(RE_DIR) "exec make run"

attach:
	@to_erl $(RE_DIR)

stop:
	@echo "init:stop()." | to_erl $(RE_DIR) 2>/dev/null
