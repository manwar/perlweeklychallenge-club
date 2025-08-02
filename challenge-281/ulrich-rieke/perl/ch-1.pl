#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub createLine {
   my $start = shift ;
   my @line ;
   for my $pos ( 0..7) {
      if ( $pos % 2 == 0 ) {
	 push( @line, $start ) ;
      }
      else {
	 if ( $start eq "light" ) {
	    push( @line, "dark" ) ;
	 }
	 else {
	    push( @line , "light" ) ;
	 }
      }
   }
   return @line ;
}

say "Enter a field on a chessboard!" ;
my $field = <STDIN> ;
chomp $field ;
my $col = substr( $field, 0 , 1 ) ;
my $row = substr( $field , 1 , 1 ) ;
my $cols = "abcdefgh" ;
my @baseline = createLine( "dark" ) ;
my $result ;
if ( $row == 1 ) {
   if ( $baseline[ index( $cols , $col ) ] eq "light" ) {
      $result = "true" ;
   }
   else {
      $result = "false" ;
   }
}
else {
   my $foot = $baseline[ index( $cols , $col ) ] ;
   my @col_line = createLine( $foot ) ;
   if ( $col_line[ $row - 1 ] eq "light" ) {
      $result = "true" ;
   }
   else {
      $result = "false" ;
   }
}
say $result ;

