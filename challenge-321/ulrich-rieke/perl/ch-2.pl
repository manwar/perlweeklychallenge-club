#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub reduceStr {
   my $string = shift ;
   while ( $string =~ s/[^#]#//g ) {
   }
   return $string ;
}

say "Enter 2 strings with zero or more #!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
if ( reduceStr( $words[0] ) eq reduceStr( $words[1] )) {
   say "true" ;
}
else {
   say "false" ;
}

