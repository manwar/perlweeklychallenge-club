#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Algorithm::Combinatorics qw{ variations };

sub three_digits_even (@ints) {
    my %r;
    for my $length (1 .. 3) {
        my $var = variations(\@ints, $length);
        while (my $v = $var->next) {
            my $n = join "", @$v;
            undef $r{$n} if 3 == length $n && 0 == $n % 2 && $v->[0] != 0;
        }
    }
    return [keys %r]
}

use Test2::V0;
plan 2 + 1;

is three_digits_even(2, 1, 3, 0),
    bag { item $_ for 102, 120, 130, 132, 210, 230, 302, 310, 312, 320;
          end },
    'Example 1';

is three_digits_even(2, 2, 8, 8, 2),
    bag { item $_ for 222, 228, 282, 288, 822, 828, 882;
          end },
    'Example 2';

is three_digits_even(123, 1234, 23, 8, 258),
    bag { item $_ for 238, 258 ; end },
    'Longer ints';
