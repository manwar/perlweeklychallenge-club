#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my $PAIR = join '|', map $_ . chr(1 + ord), 'a' .. 'y';
$PAIR = qr/(?=($PAIR))/;
sub most_frequent_letter_pair($s) {
    my %seen;
    while ($s =~ /$PAIR/g) {
        ++$seen{$1};
    }

    my @mf = ("", 0);
    # Sort ensures lexicographically first pair wins.
    for my $pair (sort keys %seen) {
        @mf = ($pair, $seen{$pair})
            if $seen{$pair} > $mf[1]
    }
    return $mf[0]
}


use Test::More tests => 2;

is most_frequent_letter_pair('abcdbca'), 'bc', 'Example 1';
is most_frequent_letter_pair('cdeabeabfcdfabgcd'), 'ab', 'Example 2';
