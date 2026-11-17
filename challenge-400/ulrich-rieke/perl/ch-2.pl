#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

sub contains {
   my $array = shift ;
   my $element = shift ;
   for my $elt( @$array ) {
      if ( $elt eq $element ) {
         return 1 ;
      }
   }
   return 0 ;
}

sub string_difference {
   my $first = shift ;
   my $second = shift ;
   my $mutations = 0 ;
   for my $pos( 0..length( $first ) - 1 ) {
      if ( substr( $first , $pos , 1 ) ne substr( $second , $pos , 1 )) {
         $mutations++ ;
      }
   }
   return $mutations ;
}

say "Enter a start genome!" ;
my $start = <STDIN> ;
chomp $start ;
say "Enter an end genome of equal length!" ;
my $end = <STDIN> ;
chomp $end ;
say "Enter some genes of equal length!" ;
my $bank = <STDIN> ;
chomp $bank ;
my @genes = split( /\s/ , $bank ) ;
if ( $start eq $end ) {
   say 0 ;
}
elsif ( contains( \@genes , $end ) == 0 ) {
   say -1 ;
}
else {
   my $mutations = string_difference( $start , $end ) ;
   say $mutations ;
   my @differences = map { string_difference( $_ , $start ) } @genes ;
   if ( all { contains( \@differences , $_ ) == 1 } (1..$mutations)) {
      say $mutations ;
   }
   else {
      say -1 ;
   }
}
