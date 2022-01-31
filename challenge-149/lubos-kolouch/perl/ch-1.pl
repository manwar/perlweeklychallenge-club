#!/usr/bin/env perl

use strict;
use warnings;
use Math::Fibonacci qw/isfibonacci/;
use List::Util qw/sum/;

sub get_numbers {
    my $what = shift;

    my $count = 0;
    my $pos = 0;

    my @output;

    while($count < $what) {

        if (isfibonacci(sum(split //, $pos))) {
            push @output, $pos;
            $count++;
        }
        $pos++;

    }
    
    return \@output;
}

use Test::More;

is_deeply(get_numbers(20), [0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44]);
done_testing;
