#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

sub isAlternating {
   my $word = shift ;
   my @pairs ;
   my $number = 0 ;
   my $vowels = "aeiou" ;
   for my $letter( split( // , $word ) ) {
      push( @pairs , [$number , $letter] ) ;
      $number++ ;
   }
   my @even_pairs = grep { $_->[0] % 2 == 0 } @pairs ;
   my @odd_pairs = grep { $_->[0] % 2 == 1 } @pairs ;
   if ( index( $vowels , substr( $word , 0 , 1 )) != -1 ) { #starts with vowel
      if (( all { index( $vowels , $_->[1] ) != -1 } @even_pairs ) && 
            (all { index( $vowels, $_->[1] ) == -1 } @odd_pairs ) ) {
         return 1 ;
      }
      else {
         return 0 ;
      }
   }
   else {
      if (( all { index( $vowels , $_->[1] ) == -1 } @even_pairs ) && 
            (all { index( $vowels , $_->[1] ) != - 1 } @odd_pairs )) {
         return 1 ;
      }
      else {
         return 0 ;
      }
   }
}

sub allSubstrings {
   my $word = shift ;
   my $len = length( $word ) ;
   my @substrings ;
   for my $start( 0..$len - 1 ) {
      for my $howmany( 1..$len - $start ) {
         push( @substrings , substr( $word , $start , $howmany ) ) ;
      }
   }
   return @substrings ;
}

sub find {
   my $word = shift ;
   my $array = shift ;
   for my $w( @$array ) {
      if ( $w eq $word ) {
         return 1 ;
      }
   }
   return 0 ;
}

say "Enter three strings with English alphabetic characters only!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my @firstSubs = allSubstrings( $words[0] ) ;
my @secondSubs = allSubstrings( $words[1] ) ;
my @thirdSubs = allSubstrings( $words[2] ) ;
my @common = grep { find( $_ , \@secondSubs ) && find( $_ , \@thirdSubs ) 
      && isAlternating( $_ ) } @firstSubs ;
if ( @common ) {
   my @sorted = sort { length( $b ) <=> length( $a ) } @common ;
   my @selected = grep { length( $_ ) == length( $sorted[0] ) } @sorted ;
   if ( @selected ) {
      say '(' . join( ',' , @selected ) . ')' ;
   }
   else {
      say "()" ;
   }
}
else {
   say "()" ;
}

