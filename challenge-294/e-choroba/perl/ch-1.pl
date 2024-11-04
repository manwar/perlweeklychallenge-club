#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub consecutive_sequence(@ints) {
    my %seen;
    @seen{@ints} = (0) x @ints;
    my $max_length = 0;
    for my $i (keys %seen) {
        next if exists $seen{ $i - 1 };

        my $j = $i;
        $seen{$j} = 1 + $seen{ $j - 1 } while exists $seen{++$j};
        $max_length = $seen{ $j - 1 } if $max_length < $seen{ $j - 1 };
    }
    return 1 + ($max_length || -2)
}

# Is the algorithm O(n)?
#
# Yes: each integer is processed twice at most: once in "for my $i",
# and possibly once more in "while exists $seen{++$j}". As an integer
# can only be part of a single sequence, it can't be processed more
# times.

use Test::More tests => 3;

is consecutive_sequence(10, 4, 20, 1, 3, 2), 4, 'Example 1';
is consecutive_sequence(0, 6, 1, 8, 5, 2, 4, 3, 0, 7), 9, 'Example 2';
is consecutive_sequence(10, 30, 20), -1, 'Example 3';

