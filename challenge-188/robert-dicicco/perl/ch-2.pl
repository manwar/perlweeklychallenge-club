#!/usr/bin/env perl

use strict;

use warnings;

use feature qw/say/;



=pod

AUTHOR: Robert DiCicco

DATE: 2022-10-25

Challenge 188 Total Zero ( Perl )



You are given two positive integers $x and $y.

Write a script to find out the number of operations needed to make both ZERO. Each operation is made up either of the followings:



$x = $x - $y if $x >= $y

or

$y = $y - $x if $y >= $x (using the original value of $x)

=cut



my @given = ([5,4], [4,6], [2,5], [3,1], [7,4]);

my $step;



sub steps {

  my $x = shift;

  my $y = shift;

  if ($x > $y) {

    $x = $x - $y;

  } elsif ($y > $x ) {

    $y = $y - $x;

  }

  $step++;

  if ( $x == $y) {

    $step++;

     say "Output: $step\n";;

    return;

   }

  steps($x,$y);

}



sub main {

  foreach my $g (@given) {

    my $x = @$g[0];

    my $y = @$g[1];

    print("Input: \$x = $x,  \$y = $y\n");

    $step = 0;

    steps($x,$y);

  }

}



main();
