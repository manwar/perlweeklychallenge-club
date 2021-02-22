#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-096/
# TASK #1 › Reverse Words

use 5.030;
use warnings;

my $S = shift;

local $, = ' ';

say reverse grep {length} split ' ', $S;
