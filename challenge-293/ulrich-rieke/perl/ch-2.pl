#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub areEqual {
   my $firstPoint = shift ;
   my $secondPoint = shift ;
   if ($firstPoint->[0] == $secondPoint->[0] && $firstPoint->[1] ==
      $secondPoint->[1] ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

sub findSlope {
   my $firstPoint = shift ;
   my $secondPoint = shift ;
   return ( $secondPoint->[1] - $firstPoint->[1] ) / ( $secondPoint->[0] 
	 - $firstPoint->[0] ) ;
}

my @points ;
for (1..3) {
   say "Enter 2 point coordinates as integers, separated by blanks!" ;
   my $line = <STDIN> ;
   chomp $line ;
   my @numbers = split( /\s/ , $line ) ;
   push( @points , \@numbers ) ;
}
if ( (areEqual( $points[0] , $points[1] ) == 0  && (areEqual( $points[1] , 
	 $points[2] ) == 0 )) && ( findSlope( $points[0] , $points[1] ) 
	 != findSlope( $points[1] , $points[2] ) )) {
   say "true" ;
}
else {
   say "false" ;
}

