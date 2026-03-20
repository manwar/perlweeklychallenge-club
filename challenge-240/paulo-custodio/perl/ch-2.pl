#!/usr/bin/env perl

# Perl Weekly Challenge 240 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-240/

use Modern::Perl;

@ARGV or die "Usage: $0 n n n...\n";

my @old = @ARGV;
my @new;
for my $i (0..$#old) {
    $new[$i] = $old[$old[$i]];
}
say "@new";
