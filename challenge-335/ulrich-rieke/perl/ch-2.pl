#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

say "Enter some numbers between 0 and 2 in brackets!" ;
my $line = <STDIN> ;
chomp $line ;
my @pairs ;
while ( $line =~ /\[\s*(\d+)\s*\,\s*(\d+)\s*\]/cg ) {
   push ( @pairs , [$1 , $2] ) ;
}
my @tictactoe ; #an array of strings as a substitute for the board
for (1..3 ) {
   push( @tictactoe , "___" ) ;
}
my $counter = 0 ;
for my $pair( @pairs ) {
   if ( $counter % 2 == 0 ) {
      substr( $tictactoe[$pair->[0]] , $pair->[1] , 1 ) = 'A' ;
   }
   else {
      substr( $tictactoe[$pair->[0]] , $pair->[1] , 1 ) = 'B' ;
   }
   $counter++ ;
}
my $row_equal = 0 ; # all letters in a row equal ? supposed to be wrong
for my $str( @tictactoe ) {
   if ( $str eq "AAA" || $str eq "BBB" ) {
      $row_equal = 1 ;
   }
}
my @transposed ; #transpose the tictactoe field 
for my $col( 0..2 ) {
   my $transpo ;
   for my $row( 0..2 ) {
      $transpo .= substr( $tictactoe[$row] , $col , 1 ) ;
   }
   push( @transposed , $transpo ) ;
}
my $column_equal = 0 ;#are all columns equal ? supposed to be wrong
for my $str( @transposed ) {
   if ( $str eq "AAA" || $str eq "BBB" ) {
      $column_equal = 1 ;
   }
}
my $first_diagonal .= substr($tictactoe[0] , 0 , 1 ) . substr( $tictactoe[1] , 1 ,
      1 ) . substr( $tictactoe[2] , 2 , 1 ) ;
my $left_diagonal_down = 0 ;
if ( $first_diagonal eq "AAA" || $first_diagonal eq "BBB" ) {
   $left_diagonal_down = 1 ;
}
my $second_diagonal .= substr( $tictactoe[2] , 0 , 1 ) . substr( $tictactoe[1] , 
      1 , 1 ) . substr( $tictactoe[0] , 2 , 1 ) ;
my $from_left_up = 0 ;
if ( $second_diagonal eq "AAA" || $second_diagonal eq "BBB" ) {
   $from_left_up = 1 ;
}
my $maybe_drawn = 0 ;
if (all { $_ == 0 } ($column_equal , $row_equal , $left_diagonal_down ,
      $from_left_up )) {
   $maybe_drawn = 1 ;
}
my $is_drawn = 0 ;
if ( $maybe_drawn) {
   if ( all { $_ !~ /_/ } @tictactoe ) {
      $is_drawn = 1 ;
   }
}
if ( all { $_ == 0 } ( $column_equal , $row_equal , $left_diagonal_down  , 
	 $from_left_up , $is_drawn) ) {
   say "Pending" ;
}
if ( $row_equal ) {
   for my $string( @tictactoe ) {
      if ( $string eq "AAA" ) {
	 say "A" ;
      }
      if ( $string eq "BBB" ) {
	 say "B" ;
      }
   }
}
if ( $column_equal ) {
   for my $string( @transposed ) {
      if ( $string eq "AAA" ) {
	 say "A" ;
      }
      if ( $string eq "BBB" ) {
	 say "B" ;
      }
   }
}
if ($left_diagonal_down ) {
   say substr( $tictactoe[0] , 0 , 1 ) ;
}
if ( $from_left_up ) {
   say substr( $tictactoe[2] , 0 , 1 ) ;
}
if ( $is_drawn ) {
   say "Draw" ;
}
