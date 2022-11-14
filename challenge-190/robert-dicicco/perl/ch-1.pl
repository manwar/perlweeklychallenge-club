#!/usr/bin/env perl

=begin pod

AUTHOR: Robert DiCicco

DATE: 2022-11-07

Challenge 190 Capital Detection ( Perl )



You are given a string with alphabetic characters only: A..Z and a..z.

Write a script to find out if the usage of Capital is appropriate

if it satisfies at least one of the following rules:



1) Only first letter is capital and all others are small.

2) Every letter is small.

3) Every letter is capital.



=cut



use strict;

use warnings;



my @words = ("Perl", "TPF", "PyThon", "raku");



for my $s (@words) {

  print "Input: \$s = \'$s\'\n";

  if ($s =~ /^[A-Z][a-z]*$/) {

    print "Output: 1\n";

  } elsif ( $s =~ /^[a-z]*$/) {

    print "Output: 2\n";

  } elsif ( $s =~ /^[A-Z]*$/) {

    print "Output: 3\n";

  } else {

    print "Output: 0\n";

  }

  print "\n";

}



=begin pod

PS G:\Projects\Perl\Challenges> perl .\CapitalDetection.pl

Input: $s = 'Perl'

Output: 1



Input: $s = 'TPF'

Output: 3



Input: $s = 'PyThon'

Output: 0



Input: $s = 'raku'

Output: 2



=cut
