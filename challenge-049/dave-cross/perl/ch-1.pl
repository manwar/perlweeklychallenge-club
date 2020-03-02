#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

# Input checking
# * We've got an argument
# * It only contains digits
# * It's not zero
die "I need a positive integer\n"
  if !@ARGV or $ARGV[0] =~ /\D/ or $ARGV[0] < 1;

my $num = shift;
my $x   = 1;

$x++ while ($num * $x) =~ /[^01]/;

say "$num x $x = ", $num * $x;
