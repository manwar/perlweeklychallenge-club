#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use DateTime ;

say "Enter a year ( positive integer ) , a month ( integer from 1 to 12 ) ," ;
say "a weekday index ( integer from 1 to 5 ) and a weekday( integer from 1 to 7 )!" ;
my $line = <STDIN> ;
chomp $line ;
my @dateParts = split( /\s/ , $line ) ;
my $d = DateTime->new( 
      year => $dateParts[ 0 ] ,
      month => $dateParts[ 1 ] , 
      day   => 1 ,
      hour  => 0 , 
      minute => 0 ,
      second => 0 , 
      nanosecond => 0 , 
      time_zone => 'Europe/Berlin' , 
) ;
my $dt = $d->set_time_zone( 'floating' ) ; #for doing date math
#add 1 day until we've reached the desired weekday
while ( $dt->day_of_week != $dateParts[ 3 ] ) {
   $dt->add( days => 1 ) ;
}
#if we want the first such weekday we're already there
if ( $dateParts[ 2 ] == 1 ) {
   say $dt->day ;
}
#otherwise , keep adding as many days as necessary to arrive at the n'th position
else {
   $dt->add( days => ( $dateParts[ 2 ] - 1 ) * 7 ) ;
   if ( $dt->month != $dateParts[ 1 ] ) {#month rollover, the given weekday doesn't exist
      say 0 ;
   }
   else {
      say $dt->day ;
   }
}
