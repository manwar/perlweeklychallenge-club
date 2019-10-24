#!/usr/bin/perl
use strict;
use warnings;
use feature qw/ say /;
no strict "refs";

our $test; # for testing this

# Randomly populate the dynamic variable
my $dynamic_variable_name = $ARGV[0];
my $random_value          = rand('99999999999');
$$dynamic_variable_name   = $random_value;

# Say random variable name and value
say 'Random variable name: ' .  $dynamic_variable_name;
say 'Random value: ' . ${$dynamic_variable_name};

# test like this: ch2.pl test
say 'Variable test is: ' .  $test
    if ($dynamic_variable_name eq 'test');


