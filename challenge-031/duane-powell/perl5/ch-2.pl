#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;

# Create a script to demonstrate creating dynamic variable name, assign a value to the variable and finally print the variable. 
# The variable name would be passed as command line argument

my ($dynamic_var, $value) = @ARGV;

eval { $$dynamic_var = $value };
print Data::Dumper->Dump([$dynamic_var],['User_defined_var']);
print "$dynamic_var = $value\n";


__END__

./ch-2.pl number 10
$User_defined_var = 'number';
number = 10

./ch-2.pl hello world
$User_defined_var = 'hello';
hello = world

./ch-2.pl foo bar
$User_defined_var = 'foo';
foo = bar
