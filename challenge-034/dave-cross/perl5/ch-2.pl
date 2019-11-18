#!/usr/bin/perl

use strict;
use warnings;

use feature 'say';

my %dispatch = (
  '+' => sub { $_[0] + $_[1] },
  '-' => sub { $_[0] - $_[1] },
  'x' => sub { $_[0] * $_[1] },
  '/' => sub { $_[0] / $_[1] },
);

@ARGV == 3 or die "Usage: Num1 Op Num2\n";

my ($x, $op, $y) = @ARGV;

unless ($dispatch{$op}) {
  die "'$op' is not a supported operator\n";
}

say "@ARGV is ", $dispatch{$op}->($x, $y);
