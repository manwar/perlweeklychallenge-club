#! /usr/bin/env perl

use strict;
use feature 'say';
use Getopt::Long;
use List::Util 'min';
use Perl6::Junction 'all';

my $verbose = 0;

GetOptions("verbose"  => \$verbose);

die 'Specify @A' unless @ARGV;

my (@A) = @ARGV;

die '@A must contain integers only' unless all(@A) == qr/^\d+$/;

if ($verbose)
{
  say ": index 0 (" . $A[0] . ") -> () -> 0";
  map { say ": index $_ ($A[$_]) -> (" . join(", ", @A[0 .. $_ -1]) . ") -> " .
       (min @A[0 .. $_ -1] < $A[$_] ? min @A[0 .. $_ -1] : 0 ) } (1 .. @A -1);
}

say "(0, ",
  join (", ",
      map { my $c = min @A[0 .. $_ -1]; $c < $A[$_] ? $c : 0 } (1 .. @A -1)),
     ")";
