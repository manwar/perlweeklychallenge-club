#!/usr/bin/perl ;;
use strict ;
use warnings ;
use feature 'say' ;

#checks whether the second time is later than the first one
sub isLater {
   my $times = shift ;
   my ( $firstHour , $firstMinutes ) = split( /:/ , $times->[0] ) ;
   my ( $secondHour , $secondMinutes ) = split( /:/ , $times->[1] ) ;
   if ( $secondHour ne $firstHour ) {
      if ( $secondHour > $firstHour ) {
         return 1 ;
      }
   }
   else {
      if ( $secondMinutes > $firstMinutes ) {
         return 1 ;
      }
   }
   return 0 ;
}

say "Enter the start and end times of a first event!" ;
my $firstEvent = <STDIN> ;
chomp $firstEvent ;
say "Enter the start and end times of a second event!" ;
my $secondEvent = <STDIN> ;
chomp $secondEvent ;
my $result = 1 ;
my @firstEventTimes = split( /\s/ , $firstEvent ) ;
my @secondEventTimes = split( /\s/ , $secondEvent ) ;
if ( $firstEventTimes[0] eq $secondEventTimes[0] ) {
#collision , result remains unchanged
}
else {
   my @times = ( $firstEventTimes[1] , $secondEventTimes[0] ) ;
   if ( isLater( \@times ) || $times[1] eq $times[0] ) {
      $result = 0 ;
   }
   else {
   }
}
if ( $result == 1 ) {
   say "true" ;
}
else {
   say "false" ;
}
