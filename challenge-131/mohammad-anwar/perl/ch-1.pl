#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply( [ consecutive_arrays(1, 2, 3, 6, 7, 8, 9) ],
           [ [1, 2, 3], [6, 7, 8, 9] ],
           'Example 1');

is_deeply( [ consecutive_arrays(11, 12, 14, 17, 18, 19) ],
           [ [11, 12], [14], [17, 18, 19] ],
           'Example 2');

is_deeply( [ consecutive_arrays(2, 4, 6, 8) ],
           [ [2], [4], [6], [8] ],
           'Example 3');

is_deeply( [ consecutive_arrays(1, 2, 3, 4, 5) ],
           [ [1, 2, 3, 4, 5] ],
           'Example 4');

done_testing;

sub consecutive_arrays {
    my @numbers = @_;

    my @arrays    = ();
    my $sub_array = [];
    my $i;
    foreach my $number (@numbers) {
        $i = $number unless defined $i;
        if ($i + 1 == $number) {
            push @$sub_array, $number;
            $i = $number;
        }
        else {
            push @arrays, $sub_array if scalar @$sub_array;;
            $sub_array = [$number];
            $i = $number;
        }
    }

    push @arrays, $sub_array if scalar @$sub_array;;

    return @arrays;
}
