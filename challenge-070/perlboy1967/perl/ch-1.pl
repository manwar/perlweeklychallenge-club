#!/usr/bin/perl

# Perl Weekly Challenge - 070
#
# Task 1 - Character Swapping
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

sub characterSwapping($$$);

die "Minimal arguments is three" 
  unless scalar(@ARGV) >=3 ;

my ($S, $C, $O) = @ARGV;
my $N = length($S);

die "Invalid arguments given"
  unless ($C >= 1 and 
          $O >= 1 and 
          $C <= $O and 
          $C +$O <= $N and
          $C <= $O);

printf q{
Input:
  $S = '%s'
  $C = %d
  $O = %d 

}, $S, $C, $O;

my $s = characterSwapping($S, $C, $O);

print qq{
Output:
  $s
};


sub characterSwapping($$$) {
  my ($S, $C, $O) = @_;

  my @s = split(//, $S);

  print "Character Swapping:\n";

  foreach my $i (1 .. $C) {
    my @i = ($i % $N, ($i + $O) % $N);

    print "  swap: $s[$i[0]] <=> $s[$i[1]] = ";

    @s[@i] = @s[reverse @i];

    print join('', @s)."\n";
  }

  return join('', @s);
}
