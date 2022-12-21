#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::Util qw{ product };

sub special_integers ($n) {
    my $count = _special_integers_shorter(length($n) - 1);
    my $from = substr '1023456789', 0, length $n;
    for ($from .. $n) {
        ++$count unless /(.).*\1/
    }
    return $count
}

sub _special_integers_shorter ($l) {
    my $count = 0;
    for my $size (1 .. $l) {
        $size = 10 if $size > 10;
        my @digits = (9, map 9 - $_, 0 .. $size - 2);
        $count += product(@digits);
    }
    return $count
}

use Test::More tests => 6;

is special_integers(15), 14, 'Example 1';
is special_integers(35), 32, 'Example 2';

is special_integers(987), 738,  'length 3';
is special_integers(9999), 5274, 'length 4';
is special_integers(99999), 32490, 'length 5';
is special_integers(999999), 168570, 'length 6';

# Too slow:
# is special_integers(999999999), 5611770, 'length 9';
