#!/bin/env perl
# """ https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/
#    Task 2
#   Left Rotation
#    19.9.2020 Lubos Kolouch """
use strict;
use warnings;

sub rotate_arr {
    # """ Process the list and fill in leaders """
    my $argv = shift;
    my $arr = $argv->{arr};
    my $first = $argv->{first};

    my @arr_copy = @$arr;
    my @new_arr = (splice(@arr_copy, $first), @arr_copy);

    return \@new_arr;
}

sub process_offsets {
    my $argv = shift;
    my $arr = $argv->{arr};
    my $elems = $argv->{elems};

    my @output;

    for my $elem (@$elems) {
        push @output, rotate_arr({ arr => $arr, first => $elem });
    }

    return \@output;
}


use Test::More;


is_deeply(process_offsets({ arr => [10, 20, 30, 40, 50], elems => [3, 4] }), 
    [[40, 50, 10, 20, 30], [50, 10, 20, 30, 40]], 'test 10, 20, 30, 40, 50');

is_deeply(process_offsets({ arr => [7, 4, 2, 6, 3], elems => [1, 3, 4] }), 
    [[4, 2, 6, 3, 7], [6, 3, 7, 4, 2], [3, 7, 4, 2, 6]], 'test 7, 4, 2, 6, 3');

done_testing;
