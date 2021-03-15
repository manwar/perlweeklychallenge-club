#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings "experimental::signatures";

my $S = shift(@ARGV) // 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG';

die "Illegal characters" unless $S =~ /^[A-Z\s]+$/;

my $N = shift(@ARGV) // 3;

die "Illegal shift $N" if $N !~ /^\-?\d+$/ || $N < -25 || $N > 25;

say join("", map { caesar($_, $N) } split(//, $S));

sub caesar ($char, $shift)
{
  return $char if $char eq " ";

  my $code = ord($char);

  $code -= $shift;

  $code += 26 if $code < 65;  # 'A'
  $code -= 26 if $code > 90;  # 'Z'

  return chr($code);
}
