#!/usr/bin/env bash

emacsclient -a "" $@ 1>/dev/null 2>/dev/null & disown
