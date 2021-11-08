#!/usr/bin/env perl
# Week 135 Task 2
# Validate SEDOL
# usage: $ perl ch-2.pl <SEDOL number>
# tests: $ prove -l t/01_validate_sedol.t

use strict;
use warnings;
use feature qw/ say /;
use lib 'lib';
use SEDOL;

my $input = $ARGV[0];
say validate_sedol($input);
