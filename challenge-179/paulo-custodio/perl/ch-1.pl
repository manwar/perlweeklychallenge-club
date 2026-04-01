#!/usr/bin/env perl

# Perl Weekly Challenge 179 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-179/

use Modern::Perl;
use Lingua::EN::Numbers 'num2en_ordinal';

say num2en_ordinal(shift);
