#! /usr/bin/env raku

use lib "lib";
use LinkedList3;

unit sub MAIN (Str $string1 = '1 2 3', Str $string2 = '3 2 1', :z(:$zero), :v(:$verbose));

my $l1 = LinkedList3.from-string($string1, :$zero);
my $l2 = LinkedList3.from-string($string2, :$zero);

my $l3 = LinkedList3.sum($l1, $l2);

if $verbose
{
  say "L1:    ", $l1.nice;
  say "L2:    ", $l2.nice;
  say "L1+L2: ", $l3.nice;
}

say $l3.nice;
