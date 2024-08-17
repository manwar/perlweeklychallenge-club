#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my $result = "false" ;
if ( $word =~ /b/ ) {
   my $pos = index( $word , 'b' ) ;
   if ( substr( $word , $pos + 1 ) !~ /a/ ) {
      $result = "true" ;
   }
}
say $result ;
