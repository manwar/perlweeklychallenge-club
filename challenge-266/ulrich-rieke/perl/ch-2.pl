#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub enter_line {
   say "Enter some integers, separated by blanks!" ;
   my $line = <STDIN> ;
   chomp $line ;
   my @numbers = split( /\s+/ , $line ) ;
   return @numbers ;
}

sub is_diagonal {
   my $matrix = shift ;
   my $len = scalar( @$matrix ) ;
   for my $i ( 0..$len - 1 ) {
      if ( $matrix->[$i]->[$i] == 0 ) {
	 return 0 ;#diagonal shouldn't be zero so it's wrong, return 0
      }
   }
   return 1 ; #unless true
}

sub is_antidiagonal {
   my $matrix = shift ;
   my $len = scalar( @$matrix ) ;
   for my $row ( 0..$len - 1 ) {
      if ( $matrix->[$row]->[$len - 1 - $row] == 0 ) {
	 return 0 ;#antidiagonal shouldn't be zero so it's wrong!
      }
   }
   return 1 ;
}

sub rest_zero {
   my $matrix = shift ;
   my $len = scalar( @$matrix ) ;
   for my $row( 0..$len - 1 ) {
      for my $col ( 0..$len - 1 ) {
	 if ( $row != $col && $row + $col != $len - 1 && $matrix->[$row]->[$col]
	       != 0 ) {
	    return 0 ;
	 }
      }
   }
   return 1 ;
}

my @matrix ;
my @row = enter_line( ) ;
my $len = scalar( @row ) ;
push( @matrix , \@row ) ;
#enforce entry of a square matrix!
for (1..$len - 1) {
   my @new_row = enter_line( ) ;
   push( @matrix , \@new_row ) ;
}
if ( is_diagonal( \@matrix ) && is_antidiagonal(\@matrix) && rest_zero( \@matrix )) {
   say "true" ;
}
else {
   say "false" ;
}
