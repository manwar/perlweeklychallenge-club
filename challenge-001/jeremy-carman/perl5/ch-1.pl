#!/usr/bin/env perl
# James Carman
use Modern::Perl;

my $string = 'Perl Weekly Challenge';
my $count = 0;

say join '', map {
    if ( $_ eq 'e' ) {
       $count++;
       'E';
    } else {
       $_;
    }
} split '', $string;

say "Count: $count";

