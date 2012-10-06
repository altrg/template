Erlang/OTP App template
=======================

Rebar+Lager Erlang/OTP App template.

Getting started
---------------

* git clone git://github.com/altrg/template.git
* ./new_app.sh yournewappname
* make deps
* make run

Usage
-----

* App config files: priv/*.conf
* Log macroses: ?L()
* Hot reload + unit tests from console: make:all([load]).
* Adding apps: edit rebar.config,  make
* Releases, upgrades, etc: see rebar docs
