#!/usr/bin/env perl

# Perl Weekly Challenge 230 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-230/

use Modern::Perl;
my @result;
for (@ARGV) {
    push @result, split //, $_;
}
say "(", join(", ", @result), ")";
