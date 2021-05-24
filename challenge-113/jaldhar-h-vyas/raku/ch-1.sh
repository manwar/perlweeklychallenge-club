#!/bin/sh

raku -e 'my ($N, $D) = @*ARGS; say ([+] (1 .. $N ).grep({ /$D/ })) == $N ?? 1 !! 0;' $@
