#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( zip ) ;

sub changeInput {
   my $melody = shift ;
   my $composer = $melody->[0] ;
   my $notes = $melody->[1] ;
   my $permutations = $melody->[2] ;
   my @correlations = zip $permutations , $notes ;
   my @sorted = sort { $a->[0] <=> $b->[0] } @correlations ;
   my $output = uc( $composer ) . " => " ;
   map { $output .= ($_->[1] . ' ') } @sorted ;
   return $output ;
}

say changeInput( [ 'Bruckner', [qw(G F# Bb C D Eb F)], [4, 7, 2, 6, 1, 5, 3] ] ) ;
