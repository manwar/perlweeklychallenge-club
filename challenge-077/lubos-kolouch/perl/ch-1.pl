#!/bin/env perl
#""" Perl Weekly challenge 077 Task 1 """
#""" https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/ """
#""" Solution Lubos Kolouch """
use strict;
use warnings;
use Data::Dumper;
use List::Util qw/sum/;

my @all_fibs;
my @solution_arr;

sub get_all_fibs {
        #""" Generate all fibonacci numbers """
        my $max_n = shift;

        unshift @all_fibs, 1;
        unshift @all_fibs, 2;

        my $fib_nr = 2;

        while ($fib_nr < $max_n) {
            $fib_nr = $all_fibs[0] + $all_fibs[1];
            unshift @all_fibs, $fib_nr;
        }
}

sub find_solutions {
        #""" Print all solutions """
        my $max_n = shift;

        @all_fibs = ();
        @solution_arr = ();
        get_all_fibs($max_n);

        partition({ max_n => $max_n });
        @solution_arr = [0] unless @solution_arr;

        warn Dumper \@solution_arr;
        return \@solution_arr;
}


sub partition {
    #""" Recursive method to get the partitions """

    my ($args) = @_;

    my $idx = $args->{idx} // 0;
    my $solution = $args->{solution} // [];
    my $max_n = $args->{max_n} // die 'No max value specified';

    my $rem_value = @$solution ? $max_n - sum(@$solution) : $max_n;

    if ($rem_value == 0) {
        push @solution_arr, [@$solution];
        return 0;
    }

    for my $i ($idx..scalar @all_fibs-1) {
        next if $all_fibs[$i] > $rem_value;
            
        my @new_arr = (@$solution, $all_fibs[$i]);
        partition({ idx => $i+1, max_n => $max_n, solution => \@new_arr });
    }
    return 1;
}

use Test::More;

is_deeply( find_solutions(6), [[5,1],[3,2,1]]);
is_deeply( find_solutions(9), [[8,1],[5,3,1]]);
is_deeply( find_solutions(-19), [[0]]);

done_testing;
