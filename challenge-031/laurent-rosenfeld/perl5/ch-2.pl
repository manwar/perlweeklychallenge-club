#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
# DON'T DO THIS
no strict 'refs'; # Needed for allowing symbolic references

@ARGV == 2 or die "Please supply two parameters.";
my ($var_name, $var_content) = @ARGV;

# This is bad, don't do it!
$$var_name = $var_content;
say "The variable is called $var_name and its value is $$var_name";
