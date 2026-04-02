#!/usr/bin/env perl

# Perl Weekly Challenge 172 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-172/

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

say "(", join(", ", map {sprintf("%.1f", $_)} five_number_summary(@ARGV)), ")";
