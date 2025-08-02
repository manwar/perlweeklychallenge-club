#!/usr/bin/env perl

# Challenge 172
#
# Task 2: Five-number Summary
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to compute the five-number summary of the given set of integers.
#
# You can find the definition and example in the wikipedia page.

use Modern::Perl;

sub median {
    my(@n) = @_;
    if (@n % 2 == 0) {
        my $i = @n / 2;
        return ($n[$i-1] + $n[$i]) / 2;
    }
    else {
        return $n[int(@n / 2)];
    }
}

sub lower_quartile {
    my(@n) = @_;
    return median(@n[0..int(@n/2)-1]);
}

sub upper_quartile {
    my(@n) = @_;
    return median(@n[int(@n/2)..$#n]);
}

sub five_number_summary {
    my(@n) = @_;
    @n = sort {$a<=>$b} @n;
    return ($n[0], lower_quartile(@n), median(@n), upper_quartile(@n), $n[-1]);
}

say join ", ", map {sprintf("%.1f", $_)} five_number_summary(@ARGV);
