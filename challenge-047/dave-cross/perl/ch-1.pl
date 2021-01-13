#!usr/bin/perl
#
# Write a script that accepts two roman numbers and operation. It should
# then perform the operation on the given Roman numbers and print the result.

use strict;
use warnings;
use feature 'say';

use Roman;

my %ops = (
  '+' => sub { $_[0] + $_[1] },
  '-' => sub { $_[0] - $_[1] },
  '/' => sub { $_[0] / $_[1] },
  'x' => sub { $_[0] * $_[1] },
);

my ($l, $op, $r) = @ARGV;

unless (exists $ops{$op}) {
  warn "'$op' is  not a recognised operation\n";
  die 'Valid operations are: ', join(', ', keys %ops), "\n";
}

say Roman( $ops{$op}->(arabic($l), arabic($r)) );
