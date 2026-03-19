#!/usr/bin/env perl

# Perl Weekly Challenge 229 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-229/

use Modern::Perl;

my @words = @ARGV;
my $count = scalar grep {!is_sorted($_)} @words;
say $count;

sub is_sorted {
    my($str) = @_;
    my $forwards = join '', sort split //, $str;
    my $backwards = join '', reverse sort split //, $str;
    return $str eq $forwards || $str eq $backwards;
}
