#!/usr/bin/env perl

=begin pod

AUTHOR: Robert DiCicco

DATE: 2022-11-21

Challenge 192 Binary Flip ( Perl )



You are given a positive integer, $n.



Write a script to find the binary flip.

Example 1



Input: $n = 5

Output: 2



First find the binary equivalent of the given integer, 101.

Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.

So Binary 010 => Decimal 2.

=cut



use strict;

use warnings;



my @ns = (5,4,6);



sub bin2dec {

    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));

}



for my $n (@ns) {

  my @out = ();

  my @binvals = split("",sprintf("%03b", $n) );

  for my $v (@binvals) {

    $v == 0 ? push(@out,1) : push(@out,0);

  }

  my $outval = join("", @out);

  my $retval = bin2dec($outval);

  print "Input: \$n = $n\n";

  print "Output: $retval\n\n";

}



=begin pod

Input: $n = 5

Output: 2



Input: $n = 4

Output: 3



Input: $n = 6

Output: 1

=cut
