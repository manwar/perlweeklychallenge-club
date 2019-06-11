#!/usr/bin/env perl6
use v6;

sub MAIN() {
    my $product = 1;
    my $euclids = (2..∞).grep(*.is-prime).map( { ($product *= $_).succ } );
    say $euclids.first(! *.is-prime);
}

