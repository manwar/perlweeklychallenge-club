#!/usr/bin/env perl
#https://theweeklychallenge.org/blog/perl-weekly-challenge-007/
use v5.10;
use List::Util 'sum';
my $upto = shift // 50;
say for grep $_ % sum(split//) == 0, 1..$upto;
