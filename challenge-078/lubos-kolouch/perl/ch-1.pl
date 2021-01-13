#!/bin/env perl
# """ https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/
#    Task 1
#    Leader Element
#    19.9.2020 Lubos Kolouch """
use strict;
use warnings;

sub process_list {
    # """ Process the list and fill in leaders """
    my $arr = shift;

    return [] unless @$arr;

    my @leaders;
    push @leaders, @$arr[-1];

    for my $elem (reverse @$arr) {
             unshift @leaders, $elem if $elem > $leaders[0];
    }
    
    return \@leaders;

}


use Test::More;

is_deeply(process_list([9, 10, 7, 5, 6, 1]), [10, 7, 6, 1], 'test 9, 10, 7, 5, 6, 1');
is_deeply(process_list([3, 4, 5]), [5], 'test 3, 4, 5');
is_deeply(process_list([]), [], 'test empty');

done_testing;
