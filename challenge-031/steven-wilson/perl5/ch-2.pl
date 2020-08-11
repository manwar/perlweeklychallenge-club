#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-10-23
# Week: 031

# Task #2
# Create a script to demonstrate creating dynamic variable name, assign
# a value to the variable and finally print the variable. The variable
# name would be passed as command line argument.
# usage: $ perl ch-2.pl foo

#use strict;
#use warnings;
use feature qw/ say /;

my $dynamic_variable_name = $ARGV[0];
$$dynamic_variable_name = "variable name was '$dynamic_variable_name'";
say "$foo";
