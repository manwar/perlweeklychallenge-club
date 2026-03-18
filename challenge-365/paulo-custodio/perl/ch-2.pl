#!/usr/bin/env perl

# Perl Weekly Challenge 365 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-365/

use Modern::Perl;
@ARGV or die "usage: $0 words...\n";
my @words = @ARGV;
say scalar(grep {is_valid($_)} @words);

sub is_valid {
    my($word) = @_;
    return $word =~ / ^ [a-z]+ ( - [a-z]+ )? [!.,]? $ /x;
}
