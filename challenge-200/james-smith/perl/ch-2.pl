#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);

## Our provided truth table...
my @truth = qw(abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg);
my @blank = map { '    ' } 0..6;

## A mapper for segment to what to draw... The rows are represented by pairs of bits 0->blank, 1->LHS, 2->RHS, 3->bar
my %parts = ( 'a' => 0x0003, 'b' => 0x0028, 'c' => 0x0a00, 'd' => 0x3000, 'e' => 0x0500, 'f' => 0x0014, 'g' => 0x00c0, );
## The four "pictures"!
my @parts = ( '    ', '|   ', '   |', ' -- ' );

sub display {
  ## Grab number & initialise output as empty.
  my( $n, @out ) = ( shift, map {''} @blank );
  while( $n ) {
    ## Get the last digit & set the display for the digit to blank.
    my( $d, @dig ) = ( $n%10, @blank );
    ## Use our truth table along with part mapping to generate values for each number
    for my $bar ( map { $parts{$_} } split //, $truth[$d] ) {
      $dig[ $_ ] |= $parts[ $bar&3 ], $bar >>= 2 for 0 .. $#blank
    }
    ## Add to the display...
    $out[ $_ ] = $dig[ $_ ].' '.$out[ $_ ] for 0..$#blank;
    ## Update N...
    $n = int( $n / 10 );
  }
  ## Render!
  say for @out;
}

display(200);
display(314159265358979);
