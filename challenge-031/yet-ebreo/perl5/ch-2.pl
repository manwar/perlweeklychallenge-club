#!/usr/bin/perl
# Create a script to demonstrate creating dynamic variable name, 
# assign a value to the variable and finally print the variable. 
# The variable name would be passed as command line argument.

use feature 'say';

die "Usage:\n\tperl ch-2.pl <variable name>\n\n" if @ARGV != 1;
die "Error: Only alphanumeric characters and underscore are allowed\n\n" if $ARGV[0]=~/\W+/;

# Not exactly what the task is asking for
# but it still demonstrates that a variable can be
# dynamically created

# The basic idea here is that if the variable can be referenced
# then the variable exists

# I used eval to basically do 
# my $varname = \$<some_variable_name>; of course with out <>
# This would create a reference to a scalar value
my $varname = eval("\\\$" . $ARGV[0]);

# Changes to the reference...
$$varname = 0|100*rand;

# Should update the value of the variable being referred to
# the code below will print the random generated value assigned
# to the reference.

say "You created a variable named \"$ARGV[0]\" and has a value of ${$ARGV[0]}\n";
say "This line prints the value of a variable named dynamic_var: [$dynamic_var]";
say "If the user inputs the same variable name, dynamic_var variable will have value otherwise it will be empty\n";
#NOTE: because of the nature of the task,
# use strict was removed.

=begin
perl .\ch-2.pl dynamic_var
You created a variable named "dynamic_var" and has a value of 78

This line prints the value of a variable named dynamic_var: [78]
If the user inputs the same variable name, dynamic_var variable will have value otherwise it will be empty

perl .\ch-2.pl my_var
You created a variable named "my_var" and has a value of 38

This line prints the value of a variable named dynamic_var: []
If the user inputs the same variable name, dynamic_var variable will have value otherwise it will be empty
=cut