#!/usr/bin/env perl

# Perl Weekly Challenge 262 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/

use Modern::Perl;
use List::Util 'max';

my @ints = @ARGV;
say max(scalar(grep {$_>0} @ints), scalar(grep {$_<0} @ints));
