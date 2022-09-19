#!/bin/sh

raku -e 'my $n = 1; (1, |(0 .. *).grep({ .is-prime })[^9]).map({ $n *= $_ }).join(q{, }).say';

