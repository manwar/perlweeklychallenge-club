#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub makeChessboard {
   my @chessboard ;
   for my $i (1..8) {
      if ( $i % 2 != 0 ) {
         push( @chessboard , "BW" x 4 ) ;
      }
      else {
         push( @chessboard , "WB" x 4 ) ;
      }
   }
   return @chessboard ;
}

say "Enter two chessboard positions separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my ( $first , $second ) = split( /\s/ , $line ) ;
my @chessboard = makeChessboard ;
if ( substr( $chessboard[substr($first , 1 , 1) - 1] , index( "abcdefgh" , substr(
               $first , 0 , 1 )) , 1 ) eq substr( $chessboard[substr($second , 1 , 1)
            - 1] , index( "abcdefgh" , substr( $second , 0 , 1 )) , 1 )) {
   say "true" ;
}
else {
   say "false" ;
}
