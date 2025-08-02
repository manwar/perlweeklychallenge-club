#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string and a positive integer separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my ( $word , $number ) = split( /\s/ , $line ) ;
$word =~ s/\-//g ; #remove all '-'
my $firstlen = length( $word ) % $number ;
my $solution ; #final resut 
if ( $firstlen != 0 ) { #length of first part
   my $firstpart = substr( $word , 0 , $firstlen ) ;
   $solution = $firstpart . "-" ;
   my $secondpart = substr( $word , $firstlen ) ;
   while ( $secondpart =~ /(.{$number})/g ) {
      $solution .= ($1 . "-") ;
   }
}
else {
   while ( $word =~ /(.{$number})/g ) {
      $solution .= ($1 . "-") ;
   }
}
$solution =~ s/\-$// ; #remove final '-'
say $solution ;
