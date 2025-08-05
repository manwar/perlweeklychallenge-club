#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some coordinates in brackets!" ;
my $line = <STDIN> ;
chomp $line ;
my @parts = split( /\]\s*\,\s*\[/ , $line ) ;
my @pairs ;
for my $pair( @parts ) {
   if ( $pair =~ /(\d+)\s*\,\s*(\d+)/ ) {
      push( @pairs , [$1 , $2] ) ;
   }
}
if ( on_straight_line(\@pairs)) {
   say "true" ;
}
else {
   say "false" ;
}

sub on_straight_line {
   my $coords = shift ;
   if (($coords->[1]->[1] == $coords->[0]->[1] && $coords->[2]->[1] == 
	 $coords->[1]->[1] ) || ( $coords->[1]->[0] == $coords->[0]->[0] &&
	    $coords->[2]->[0] == $coords->[1]->[0] )) {
      return 1 ;
   }
   else {
      my $slope_one = ($coords->[1]->[1] - $coords->[0]->[1] ) / 
	 ($coords->[1]->[0] - $coords->[0]->[0] ) ;
      my $slope_two = ( $coords->[2]->[1] - $coords->[1]->[1] ) / (
	    $coords->[2]->[0] - $coords->[1]->[0] ) ;
      if ( $slope_one == $slope_two ) {
	 return 1 ;
      }
      else {
	 return 0 ;
      }
   }
}

