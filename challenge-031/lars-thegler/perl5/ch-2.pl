#!/usr/bin/env perl

use Modern::Perl;

# Create a script to demonstrate creating dynamic variable name,
# assign a value to the variable and finally print the variable.
# The variable name would be passed as command line argument.

my $variable_name = shift or die 'missing variable name';

no strict 'refs';
$$variable_name = 42;

say "name=$variable_name, value=$$variable_name";