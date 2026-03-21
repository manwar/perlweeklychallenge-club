#!/usr/bin/env perl

# Perl Weekly Challenge 219 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-219/

use Modern::Perl;
use List::Util 'min';

@ARGV>=4 or die "Usage:$0 cost1 cost7 cost30 days...\n";
my($cost1, $cost7, $cost30, @days) = @ARGV;
my $min_cost = calc_min_cost(0, $cost1, $cost7, $cost30, @days);
say $min_cost;

sub calc_min_cost {
    my($total, $cost1, $cost7, $cost30, @days) = @_;

    return $total if @days==0;

    my $total1 = calc_min_cost($total + $cost1, $cost1, $cost7, $cost30, trim_days(1, @days));
    my $total7 = calc_min_cost($total + $cost7, $cost1, $cost7, $cost30, trim_days(7, @days));
    my $total30 = calc_min_cost($total + $cost30, $cost1, $cost7, $cost30, trim_days(30, @days));

    return min($total1, $total7, $total30);
}

sub trim_days {
    my($num_days, @days) = @_;
    die unless @days;
    my $day1 = $days[0];
    while (@days && $days[0] < $day1+$num_days) {
        shift @days;
    }
    return @days;
}
