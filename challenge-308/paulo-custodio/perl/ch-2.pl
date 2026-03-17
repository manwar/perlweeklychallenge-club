#!/usr/bin/env perl

# Perl Weekly Challenge 308 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-308/

use Modern::Perl;

my($encoded, $initial) = @ARGV;
my @encoded = map {$_+0} split ' ', $encoded;   # convert to number
$initial += 0;                                  # convert to number

my @decoded = ($initial);
for (@encoded) {
    push @decoded, $decoded[-1] ^ $_;
}

say "(", join(", ", @decoded), ")";
