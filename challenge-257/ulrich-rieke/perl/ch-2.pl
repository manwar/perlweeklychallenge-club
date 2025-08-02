#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any all max) ;

sub findOnePos { #find the first position of a 1 if there is one
   my $row = shift ;
   my $len = scalar( @$row ) ;
   my $pos = 0 ;
   while ( $row->[$pos] == 0 ) {
      $pos++ ;
      if ( $pos == $len ) {
	 last ;
      }
   }
   if ( $pos < $len ) {
      if ( $row->[$pos] == 1 ) {
	 return $pos ;
      }
      else {
	 return -1 ;
      }
   }
   else {
      return -1 ;
   }
}

#determine whether a possible non-0 entry in a row is a 1
sub hasLeadingOne { 
   my $matrix = shift ;
   for my $row ( @$matrix ) {
      if ( any { $_ != 0 } @$row ) {
	 my $pos = 0 ;
	 while ( $row->[$pos] == 0 ) {
	    $pos++ ;
	 }
	 if ( $row->[$pos] != 1 ) {#it not a 1
	    return 0 ; #return false
	 }
      }
   }
   return 1 ;
}

sub zeroesAtBottom {
   my $matrix = shift ;
   my @rownum ;#create an array of row number and row content
   my $count = 0 ;
   for my $row( @$matrix ) {
      my @currentrow = @$row ;#it's better to dereference...!
      push( @rownum, [$count , join( '' , @currentrow ) ] ) ;
      $count++ ;
   }
   my @allZeroIndices ;#indices of lines consisting of 0's only
   my @theRest ; #the other lines
   for my $pair( @rownum ) {
      my @r = split( // , $pair->[1] ) ; #split the line content
      if ( all { $_ eq '0' } @r ) {#if it only contains '0'
	 push @allZeroIndices , $pair->[0] ;#grab the line index
      }
      else {
	 push @theRest , $pair->[0] ;
      }
   }
   my $maximum = max( @theRest ) ;
#the maximum of the line indices of lines containing not only 0 must be 
#smaller than all indices of lines containing only 0
   if ( all { $_ > $maximum } @allZeroIndices ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

#do leading ones follow through from left to right ?
sub staggeredOnes {
   my $matrix = shift ;
   my @leadingOnes ;#positions of leading ones
   for my $row( @$matrix ) {
      if ( any { $_ != 0 } @$row ) {
	 my $num = findOnePos( $row ) ;
	 if ( $num != -1 ) { #we found a leading one, see function above
	    push @leadingOnes , $num ;
	 }
      }
   }
   my $len = scalar( @leadingOnes ) ;
   if ( $len == 0 || $len == 1 ) { #staggered criterion does not apply
      return 1 ;
   }
   else {
      if ( $len == 2 ) {
	 if ( $leadingOnes[1] > $leadingOnes[0] ) {
	    return 1 ;
	 }
	 else {
	    return 0 ;
	 }
      }
      if ( $len > 2 ) {
	 for my $i (0..$len - 2 ) {
	    if ( $leadingOnes[ $i + 1 ] < $leadingOnes[ $i ] ) {
	       return 0 ;
	    }
	 }
	 return 1 ;
      }
   }
}

#do all leading ones live in a column of 0's only ?
sub allZeroesInLeadingOneColumn {
   my $matrix = shift ;
   my $len = scalar( @$matrix ) ;
   my @leadingOnePositions ;#contains arrays of rows and columns of leading 1's
   for my $r( 0..$len - 1 ) {
      my $row = $matrix->[$r] ;#current row
      if ( any { $_ != 0 } @$row ) {
	 my $num = findOnePos( $row ) ;
	 if ( $num != -1 ) { #we found a leading 1 position
	    push @leadingOnePositions , [$r , $num] ;
	 }
      }
   }
   for my $pair( @leadingOnePositions ) {
      for my $i (0..$len - 1 ) {#for all rows in the matrix
	 if ( $pair->[0] != $i ) {#if the current row is not equal to the row 
#number of a leading 1
	    if ( $matrix->[$i]->[$pair->[1]] != 0 ) {#it must be unequal zero
	       return 0 ; #short circuiting if the matrix entry above or below
#is not 0
	    }
	 }
      }
   }
   return 1 ;
}

say "Enter some integers, separated by blanks!" ;
say "Enter <return> to end entry!" ;
my @matrix ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ) {
   my @row = split( /\s+/ , $line ) ;
   push @matrix, \@row ;
   $line = <STDIN> ;
   chomp $line ;
}
#test all conditions
if ( hasLeadingOne( \@matrix ) && zeroesAtBottom( \@matrix ) && staggeredOnes(
	 \@matrix ) && allZeroesInLeadingOneColumn( \@matrix ) ) {
   say 1 ;
}
else {
   say 0 ;
}
