#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a number string!" ;
my $number = <STDIN> ;
chomp $number ;
say "Enter a number character!" ;
my $char = <STDIN> ;
chomp $char ;
if ( $number =~ /^$char(.)/ && $char < $1 ) {
   $number =~ s/^(.)// ;
}
else {
   my $pos = rindex( $number , $char ) ;
   if ( $pos != -1 ) {
      $number = substr( $number , 0 , $pos ) . substr( $number , $pos + 1 ) ;
   }
}
say $number ;
