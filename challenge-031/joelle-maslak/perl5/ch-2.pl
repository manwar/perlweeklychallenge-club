#!/usr/bin/env perl
use v5.14;
# use strict;  Nope!
use warnings;

if ( @ARGV != 2 ) { die("Provide variable name and value") }

# Note all sorts of bad things can still be done with this code - like a
# user might pass in the name of an existing variable, might start a
# variable name with a number, etc.  We make it safer but not safe.

my $varname = $ARGV[0];
my $value   = $ARGV[1];

die "Invalid variable name" if $varname !~ m/^ \w+ $/s; # Doesn't catch everything

$$varname = $value;
say "\$$varname = $value";

