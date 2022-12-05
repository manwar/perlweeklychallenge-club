#!/bin/sh

raku -e 'my $n = @*ARGS[0]; (("0" x $n) .. ("1" x $n)).join(q{, }).say;' $@
