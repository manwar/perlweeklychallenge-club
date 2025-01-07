#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use experimental qw( signatures );

use Memoize qw{ memoize };

sub delete_and_earn(@ints) { return _delete_and_earn(@ints) }

# Sppedup: 7.164s versus 0.074s.
memoize('_delete_and_earn');
sub _delete_and_earn(@ints) {
    return 0 if ! @ints;

    my $max = 0;
    for my $int (@ints) {
        my @rest = grep $_ != $int + 1 && $_ != $int - 1, @ints;
        my $seen_int = 0;
        @rest = grep $_ != $int || $seen_int++, @rest;
        my $points = $int + _delete_and_earn(@rest);
        $max = $points if $points > $max;
    }
    return $max
}

use Test::More tests => 2 + 1;

is delete_and_earn(3, 4, 2), 6, 'Example 1';
is delete_and_earn(2, 2, 3, 3, 3, 4), 9, 'Example 2';
is delete_and_earn(map $_ * 2, 1 .. 10), 110, 'Longer';
