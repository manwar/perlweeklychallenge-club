#!/bin/sh

perl6 -e 'my $sum = [*] @*ARGS; (0 ..^ @*ARGS.elems).map({ $sum / @*ARGS[$_]; }).join(q{, }).say;' $@