#!/usr/bin/env perl

# 031-2
# Create a script to demonstrate creating dynamic variable name, assign a value
# to the variable and finally print the variable. The variable name would be
# passed as command line argument.

use 5.030;
use strict;
use warnings;

my $var_name = pop;
eval 'my $' . $var_name . ' = time;'
  . 'say chr(36), "$var_name = $' . $var_name . '";';


__DATA__
# Output:

$ perl ch-2.pl myvar1
$myvar1 = 1572022798
