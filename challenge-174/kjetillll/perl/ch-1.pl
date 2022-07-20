#!/usr/bin/perl
use List::Util 'sum'; use v5.10; use strict; use warnings;

my $want = 19;
my $n = 0;

while( $want > 0 ) {

    my @d = split //, $n;       #array d gets digits

    say $n and $want-- if $n == sum( map $d[$_-1]**$_, 1..@d);

    $n++;

}
