#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{say signatures };
no warnings qw{experimental};

my @arr;
push @arr, [ 'abcde', 'a*e' ];
push @arr, [ 'abcde', 'a*d' ];
push @arr, [ 'abcde', '?b*d' ];
push @arr, [ 'abcde', 'a?c*e' ];

for my $n (@arr) {
    my $p = pattern_match( $n->@* );
    say $n->[0];
    say $n->[1];
    say $p;
}

sub pattern_match ( $S, $P ) {
    my $pattern = $P;
    $pattern =~ s/\*/.*/g;
    $pattern =~ s/\?/.?/g;
    $pattern = qq{^$pattern\$};
    return $S =~ /$pattern/mix ? 1 : 0;
}

