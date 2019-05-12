#!/usr/bin env perl6
use lib '.';
use ModuleCH01;

sub MAIN( UInt:D $max ) {
    .put if is-niven($_) for 0..$max;
}
