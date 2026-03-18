#!/usr/bin/env perl

# Perl Weekly Challenge 280 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-280/

use Modern::Perl;

my $str = shift || "";
say double_letter($str);

sub double_letter {
    my($str) = @_;

    my %found;
    for (split //, $str) {
        return $_ if $found{$_}++;
    }
    return "";
}
