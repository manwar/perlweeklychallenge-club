#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

use Getopt::Long;
use Algorithm::Combinatorics 'permutations';
use Math::Base::Convert;

no warnings qw(experimental::signatures);

my $verbose =  0;

GetOptions("verbose" => \$verbose);

my $base = shift(@ARGV);

die "Illegal base." unless $base =~ /^\d+$/;
die "Illegal base. Use 2..36 only" if $base < 2 or $base > 36;

my @digits = ( 0..9,'A'..'Z' )[0 .. $base -1];

my $converter = new Math::Base::Convert(\@digits, 10);

for my $permutation (reverse permutations(\@digits))
{
  my $candidate = join("", @$permutation);

  my $decimal = $converter->cnv($candidate);
  my $sqrt    = sqrt $decimal;

  say ": Checking $candidate (decimal: $decimal root: $sqrt)" if $verbose;

  if ($sqrt =~ /^\d+$/)
  {
    substr($candidate, 0,1) eq "0" ? say substr($candidate, 1) : say $candidate;
    last;
  }
}
