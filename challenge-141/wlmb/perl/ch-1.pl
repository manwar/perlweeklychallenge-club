#!/usr/bin/env perl
# Perl weekly challenge 141
# Task 1: Number divisors
#
# See https://wlmb.github.io/2021/11/29/PWC141/#task-1-number-divisors
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
#Set defaults and params. from com. line
my %params=(try=>100, divisors=>8, results=>10, @ARGV);
my ($try, $divisors, $results)
    =@params{qw(try divisors results)};
my $cells=zeroes $try;
# count divisors for each number
$cells($_:-1:$_)+=1 for(1..$try-1);
# find all d-multiples
my $multiples=$cells->xvals->where($cells==$divisors);
die "Need to increase try" unless $multiples->nelem>=$results;
my $out=$multiples(0:$results-1);
say "try=$try, divisors=$divisors, results=$results, out=$out";
