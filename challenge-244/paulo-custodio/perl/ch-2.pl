#!/usr/bin/env perl

# Perl Weekly Challenge 244 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-244/

use Modern::Perl;
use List::Util qw( min max );

@ARGV or die "Usage: $0 n n n...\n";
say power(@ARGV);

sub calc_power {
    my(@n) = @_;
    return (max(@n)**2) * min(@n);
}

sub power {
    my(@n) = @_;
    my $sum = 0;
    for (all_combinations(@n)) {
        my @combo = @$_;
            $sum += calc_power(@combo);
        }
    return $sum;
}

# Generate combinations
sub combinations_size_k {
    my ($k, $arr, $start, $current, $results) = @_;

    # Full combination collected
    if (@$current == $k) {
        push @$results, [ @$current ];
        return;
    }

    # Backtracking
    for (my $i = $start; $i < @$arr; $i++) {
        push @$current, $arr->[$i];
        combinations_size_k($k, $arr, $i + 1, $current, $results);
        pop @$current;
    }
}

sub all_combinations {
    my(@elems) = @_;
    my @results;

    # Loop through sizes 1..N
    for my $k (1 .. scalar(@elems)) {
        combinations_size_k($k, \@elems, 0, [], \@results);
    }

    return @results;
}
