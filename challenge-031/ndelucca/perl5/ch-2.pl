#!/usr/bin/perl

# Create a script to demonstrate creating dynamic variable name, assign a value to the variable and finally print the variable.
# The variable name would be passed as command line argument.

use strict;
use warnings;

my $name = shift || die "Choose a variable name!";
my $value = int rand(10000);

no strict 'refs';

$$name = $value;
print "Variable name: $name\nVariable value: $$name\n";

# Looks the other way, hoping nobody notices...
use strict 'refs';

