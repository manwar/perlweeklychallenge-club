#!/bin/sh

raku -e 'Date(@*ARGS[0]).day-of-year.say' "$@"
