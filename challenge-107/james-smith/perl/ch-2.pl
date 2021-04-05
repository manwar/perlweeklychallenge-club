#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
#use Test::More;
use lib '.';
use Calc;

say join "\n", sort keys %Calc::;

