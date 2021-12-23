#!/usr/bin/perl

# Challenge 031
#
# Task #2
# Create a script to demonstrate creating dynamic variable name, assign a value
# to the variable and finally print the variable. The variable name would be
# passed as command line argument.

use Modern::Perl;
no strict 'refs';

my $name = shift || die "Usage: ch-2.pl name\n";

${$name} = 10;
say ${$name};
