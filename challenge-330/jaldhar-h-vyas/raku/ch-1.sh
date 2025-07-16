#!/bin/sh

raku -e '$_=@*ARGS[0];while s/\D\d// {};.say' "$@"
