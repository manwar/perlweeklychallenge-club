#!/bin/env raku

sub MAIN(*@N) {
    put (^@N.elems).map({ @N[0..$_].sum / ($_+1) });
}
