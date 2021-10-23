#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

my $n = $ARGV[0] // "";

die "integer only" unless $n =~ /^\-?[1-9]\d*$/;

$n = abs($n) if $n < 0;

if (length($n) % 2 == 0)
{
  say "even number of digits";
}
elsif (length($n) < 3)
{
  say "too short";
}
else
{
  say substr($n, (length($n) -3) / 2, 3);
}
