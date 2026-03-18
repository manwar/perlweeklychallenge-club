#!/usr/bin/env perl

# Perl Weekly Challenge 284 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/

use Modern::Perl;

my @ints = @ARGV;
my %count;
$count{$_}++ for @ints;
my @lucky =
        sort {$b <=> $a}
        grep {$_ == $count{$_}} @ints;
say !@lucky ? -1 : $lucky[0];
