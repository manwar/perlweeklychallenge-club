#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

for my $d ( 7 .. 7 ) {
    for my $n ( 20 .. 30 ) {
        my $o = represent_int( $n, $d );
        say <<"END";
    INPUT: N = $n , D = $d
    OUTPUT: $o
END

    }
}

sub represent_int ( $n, $d ) {
    my $s = 0;
    for my $i ( 1 .. $n ) {
        $s += $i if $i =~ /$d/;
    }
    return $n == $s ? 1 : 0;
}
