#! /usr/bin/env perl

use strict;
use feature 'say';
use List::Util 'uniq';
use Getopt::Long;

my $verbose = 0;

GetOptions("verbose"  => \$verbose);

my $A = shift(@ARGV) // die 'Please specify $A';
my $B = shift(@ARGV) // die 'Please specify $B';

if (length($A) != length($B))
{
  say ": Different length" if $verbose;
  say 0;
  exit;
}

my %A;

for my $index (0 .. length $A -1)
{
  my $pair0 = substr($A, $index, 1);
  my $pair1 = substr($B, $index, 1);
    
  say ": Pair: $pair0 -> $pair1" if $verbose;

  if (defined %A{$pair0})
  {
    if ($A{$pair0} eq $pair1)
    {
      say ": Duplicate of $pair0 (value: $pair1)" if $verbose;
      next;
    }
    
    say ": Redeclaration of $pair0 (values: " . $A{$pair0} . " and " . $pair1 . ")" if $verbose;
    say 0;
    exit;  
  }
      
  $A{$pair0} = $pair1;
}

if (scalar keys %A == scalar uniq values %A)
{
  say 1;
}
else
{
  say ': Redeclaration of value (in $B).' if $verbose;
  say 0;
}
