#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::MoreUtils qw( mesh ) ;

sub findInterleaved { #if two strings have unequal lengths
  my ($greater , $smaller ) = @_ ;
  my ( $interleavedA , $interleavedB ) ;
  my $lenA = length $greater ;
  my $lenB = length $smaller ;
  my $paired = substr( $greater , 0 , $lenB) ;
  my @A = split // , $paired ;
  my @B = split // , $smaller ;
  $interleavedA = join( '' , mesh( @A, @B) ) . substr( $greater ,
    $lenB , $lenA - $lenB) ;
  $interleavedB = join( '' , mesh( @B , @A) ) . substr( $greater ,
    $lenB , $lenA - $lenB) ;
  return ($interleavedA , $interleavedB) ;
}

my ($A , $B , $C) = @ARGV ;
my $interleavedA ;
my $interleavedB ;
my $lenA = length $A ;
my $lenB = length $B ;
my @A = split // , $A ;
my @B = split // , $B ;
if ( $lenA == $lenB ) {
  $interleavedA = join( '' , mesh( @A, @B) ) ;
  $interleavedB = join( '' , mesh( @B, @A) ) ;
}
if ( $lenA > $lenB ) {
  ($interleavedA , $interleavedB) = findInterleaved( $A , $B ) ;
}
if ( $lenB > $lenA ) {
  ($interleavedA , $interleavedB) = findInterleaved($B, $A  ) ;
}
if ( $interleavedA eq $C or $interleavedB eq $C ) {
  say 1 ;
}
else {
  say 0 ;
}
