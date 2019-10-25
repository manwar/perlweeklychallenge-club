#!/usr/bin/perl6
use v6;

use Test;

# 31.2 Create a script to demonstrate creating dynamic variable name, assign a value to the variable and finally print the variable. The variable name would be passed as command line argument.

sub MAIN($name='test'){
    # From http://rosettacode.org/wiki/Dynamic_variable_names#Perl_6
    # Don't think this works on Rakudo > 2018.03
    my $var=$name;
    say "variable named $var is {$::('var')}";
    $::('var')=137;
    say "variable named $var is {$::('var')}";

}

