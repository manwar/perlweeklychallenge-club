#!/usr/bin/env perl

# Perl Weekly Challenge 319 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-319/

use Modern::Perl;

@ARGV or die "usage: $0 words...\n";
say scalar grep {match($_)} @ARGV;

sub match {
    my($word) = @_;
    return 1 if /^[aeiou]/i;
    return 1 if /[aeiou]$/i;
    return 0;
}
