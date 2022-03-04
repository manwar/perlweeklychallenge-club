#!/usr/bin/perl
use warnings;
use strict;
use experimental qw{ signatures };

use Math::Prime::Util qw{ is_prime };

my @P = (1, 1, 1);
sub padovan_number ($n) {
    --$n;
    push @P, $P[-2] + $P[-3] while $#P < $n;
    return $P[$n]
}

sub padovan_prime ($n) {
    my @pp;
    my $i = 5;
    while (@pp < $n) {
        my $pn = padovan_number($i++);
        push @pp, $pn if is_prime($pn);
    }
    return @pp
}

use Test::More tests => 1;
is_deeply [padovan_prime(10)],
    [2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057],
    'Example 1';
