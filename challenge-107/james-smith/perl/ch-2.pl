#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
#use Test::More;
use lib '.';
use Calc;

## %{class}:: contains a list of the methods for the class,
## so we can just dump these (to make it deterministic) we
## sort first....

say join "\n", sort keys %Calc::;

