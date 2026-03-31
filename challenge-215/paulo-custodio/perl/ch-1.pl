#!/usr/bin/env perl

# Perl Weekly Challenge 215 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-215/

use Modern::Perl;

sub is_sorted {
    my($str) = @_;
    my $sorted = join '', sort {$a cmp $b} split //, $str;
    return $str eq $sorted;
}

sub odd_out {
    my(@in) = @_;
    return scalar(grep {!is_sorted($_)} @in);
}

say odd_out(@ARGV);
