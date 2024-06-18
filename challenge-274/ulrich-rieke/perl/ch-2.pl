#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

#given a minute and the array of bus schedules , find an array that orders
#the bus lines by proximity to the given minute, storing the number of the
#bus line first
sub findNextStarts {
   my $number = shift ;
   my $schedule = shift ;
   my @startList ;
   for my $i (0..scalar( @$schedule ) - 1) {
      my $start = $schedule->[$i]->[1] ;
      while ( $start < $number ) {
	 $start += $schedule->[$i]->[0] ;
      }
      push ( @startList , [$i , $start] ) ;
   }
   my @sorted = sort { $a->[1] <=> $b->[1] } @startList ;
   return @sorted ;
}
#find the arrival times in the order of the start times
sub findNextArrivals {
   my $number = shift ; #the minute
   my $schedule = shift ; #the bus line schedule
   my $startList = shift ; #the array of [bus line number , start time]
   my @arrivals ; #times of arrival in the city
   for my $st ( @$startList ) {
      push( @arrivals , $st->[1] + $schedule->[$st->[0]]->[2] ) ;
   }
   return @arrivals ;
}
#we have to let 1 bus pass if the next bus arrives strictly earlier , 
#provided the no two buses start or arrive at the same time
sub myCondition {
   my $number = shift ;
   my $schedule = shift ;
   my @nextStarts = findNextStarts( $number , $schedule ) ;
   my @arrivals = findNextArrivals( $number , $schedule , \@nextStarts ) ;
   if ( ($nextStarts[ 0 ]->[1] != $nextStarts[1]->[1]) && ($arrivals[0] != 
	    $arrivals[1] ) && ( min( @arrivals ) == $arrivals[ 1 ] ) ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter the schedule of some bus lines in 3 numbers each!" ;
my @lines ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ) {
   push @lines , $line ;
   say "Next bus line !" ;
   $line = <STDIN> ;
   chomp $line ;
}
my @times ;
for my $inline ( @lines ) {
   my @schedule = split ( /\s+/ , $inline ) ;
   push ( @times , \@schedule ) ;
}
my @selected = grep { myCondition( $_ , \@times ) } (0..59) ;
if ( @selected ) {
   say  "[" . join( ',' , @selected) . "]" ;
}
else {
   say "[]" ;
}
