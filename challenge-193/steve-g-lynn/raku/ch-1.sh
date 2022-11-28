#!/bin/sh

raku -e 'use MONKEY-SEE-NO-EVAL; for (EVAL("0b" ~ (0 x @*ARGS[0]) ~ ".." ~ "0b" ~ (1 x @*ARGS[0]))) {printf("%b\n",Int($_))}' $@

