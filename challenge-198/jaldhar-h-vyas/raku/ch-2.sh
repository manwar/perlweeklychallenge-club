#!/bin/sh

raku -e 'my $n = @*ARGS[0]; (0 .. $n).grep({ .is-prime }).elems.say' $@