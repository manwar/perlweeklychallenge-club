#!/usr/bin/env perl

# Perl Weekly Challenge 225 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-225/

use Modern::Perl;
use List::Util 'max';

say max(map {scalar(split ' ', $_)} @ARGV);
