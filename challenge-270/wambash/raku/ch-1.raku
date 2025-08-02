#!/usr/bin/env raku
use v6.*;

sub special-position (+@matrix) {
    my $columns := ([Z^] @matrix).grep: *.so,:k;
    my $rows    := @matrix.grep: *.one,:k;

    $rows X, $columns
    andthen .grep: -> ($r, $c) { @matrix[$r;$c] }\
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply special-position(<1 1 0>,<0 0 1>,<1 0 0>),1;
    is-deeply special-position(<1 0 0>,<0 0 1>,<1 0 0>),1;
    is-deeply special-position(<1 0 0>,<0 1 0>,<0 0 1>),3;
    done-testing;
}

multi MAIN (+@matrix) {
    say special-position @matrix.map( *.comb».Int)
}
