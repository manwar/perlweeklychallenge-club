#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
use Getopt::Long;

no warnings "experimental::signatures";

my $verbose = 0;

GetOptions("verbose"  => \$verbose);

my $B = shift(@ARGV) // '101100101';

die "Not a binary number" unless $B =~ /^[01]+$/;

my $S = shift(@ARGV) // 3;

die "Not an integer" unless $S =~ /^[1-9][0-9]*$/;
die "Not a legal length" if length($B) % $S;

my @B     =  comb($B, $S);
my $first = shift(@B);
my $total = 0;

for my $current (@B)
{
  my $flip = bit_diff($first, $current);
  $total += $flip;
  say ": $first -> $current -> Flip: $flip" if $verbose;
}

say $total;

sub bit_diff ($a, $b)
{
  my $flip = 0;

  for my $index (0 .. length($a))
  {
    $flip++ if substr($a, $index,1) ne substr($b, $index,1);
  }

  return $flip;
}

sub comb ($string, $length = 1)
{
  my @result;

  while ($string)
  {
    push(@result, substr($string, 0, $length));
    $string = substr($string, $length);
  }
  return @result;
}
