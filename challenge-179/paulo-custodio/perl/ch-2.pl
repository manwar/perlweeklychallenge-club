#!/usr/bin/env perl

# Perl Weekly Challenge 179 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-179/

use Modern::Perl;
use List::Util 'max';
use open qw(:std :utf8);

my @bars = ("\N{U+2581}", "\N{U+2582}", "\N{U+2583}", "\N{U+2584}",
            "\N{U+2585}", "\N{U+2586}", "\N{U+2587}", "\N{U+2588}");

my @nums = @ARGV;
my $max = max(@nums);
my @height = map {int(($_ / $max)*7)} @nums;
my @chars = @bars[@height];
say @chars;
