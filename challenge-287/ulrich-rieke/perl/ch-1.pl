#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a password!" ;
my $word = <STDIN> ;
chomp $word ;
my $totalsteps = 0 ;
if ( length $word < 6 ) {
   $totalsteps += 6 - length $word ;#complement the word!
}
if ( $word !~ /[a-z]/ ) {
   if ( length $word >= 6 ) { #replace one character
      $totalsteps += 1 ;
   }
}
if ( $word !~ /[A-Z]/ ) {
   if ( length $word >= 6 ) {#replace one character
      $totalsteps += 1 ;
   }
}
if ( $word !~ /\d/ ) {
   if ( length $word >= 6 ) {#replace one character
      $totalsteps += 1 ;
   }
}
if ( $word =~ /(.)\1\1/ ) {#replace one character 
   $totalsteps += 1 ;
}
say $totalsteps ;
