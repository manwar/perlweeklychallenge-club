#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
#use Test::More;
use lib '.';
require Calc_Require;
use     Calc_Use;

## %{class}:: contains a list of the methods for the class,
## so we can just dump these (to make it deterministic) we
## sort first....
##
## We "import" the classes in two ways... use & require.
##
## By "require"ing the class - we don't get the additional
## import method added to the class... (and so get the same
## list of fns as in the question)

say join "\n  ",'Calc_Require:', sort keys %Calc_Require::;
say '';
say join "\n  ",'Calc_Use:',     sort keys %Calc_Use::;

