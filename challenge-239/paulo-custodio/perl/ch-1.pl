#!/usr/bin/env perl

# Perl Weekly Challenge 239 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-239/

use Modern::Perl;

my @words = split(/,/, "@ARGV");
for (@words) {
    $_ = join '', split ' ', $_;
}
say $words[0] eq $words[1] ? 'true' : 'false';
