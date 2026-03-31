#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findPossibilities {
   my $timeterm = shift ;
   my $possibilities = 1 ;
   if ( $timeterm =~ /^\?\?/ ) {
      $possibilities *= 24 ;
   }
   else {
      if ( $timeterm =~ /^\?(\d)/ ) {
         my $number = $1 ;
         if ( $number < 4 ) {
            $possibilities *= 3 ;
         }
         else {
            $possibilities *= 2 ;
         }
      }
      if ( $timeterm =~ /^(\d)\?/ ) {
         my $number = $1 ;
         if ( $number < 2 ) {
            $possibilities *= 10 ;
         }
         else {
            $possibilities *= 4 ;
         }
      }
   }
   if ( $timeterm =~ /\?.$/ ) {
      $possibilities *= 6 ;
   }
   if ( $timeterm =~ /\?$/ ) {
      $possibilities *= 10 ;
   }
   return $possibilities ;
}

say findPossibilities( "?2:34" ) ;
say findPossibilities( "?4:?0" ) ;
say findPossibilities( "??:??" ) ;
say findPossibilities( "?3:45" ) ;
say findPossibilities( "2?:15" ) ;
