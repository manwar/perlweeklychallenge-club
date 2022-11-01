#!/usr/bin/env perl

=pod

AUTHOR: Robert DiCicco

DATE: 2022-10-31

Challenge 189 Greater Character ( Perl )



You are given an array of characters (a..z) and a target character.

Write a script to find out the smallest character in the given array

lexicographically greater than the target character.



=cut



use strict;

use warnings;

use List::MoreUtils qw/minmax/;

use signatures;



my @arr =  (["e", "m", "u", "g"], ["d", "c", "e", "f"], ["j","a","r"], ["d", "c", "a", "f"], ["t", "g", "a", "l"]) ;

my @target = qw[b a o a v ];



sub TestValues( $a, $tv ) {

  my $x;

  my $sz = scalar @$a;

  print "Input: \@array = qw\(@$a\), target = $tv\n";

  my @out = ();

  for ($x = 0; $x < $sz; $x++){

    if (@$a[$x] gt $tv) {

      push(@out, @$a[$x]);

    }

  }

  @out = sort(@out);

  scalar @out > 0 ? print $out[0] . "\n\n" : print $tv . "\n\n";

}



sub main {

  my $cnt = 0;

  foreach my $p (@arr) {

    TestValues($p,$target[$cnt++]);

  }

}



main();



=pod

----------------------------------------------------

SAMPLE OUTPUT

PS G:\Projects\Perl\Challenges> perl .\GreaterChar.pl

Input: @array = qw(e m u g), target = b

e



Input: @array = qw(d c e f), target = a

c



Input: @array = qw(j a r), target = o

r



Input: @array = qw(d c a f), target = a

c



Input: @array = qw(t g a l), target = v

v

=cut
