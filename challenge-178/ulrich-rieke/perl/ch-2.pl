#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use DateTime ;

say "Please enter a datetime as year-month-dayThour:minutes!" ;
my $dateTimeStr = <STDIN> ;
chomp $dateTimeStr ;
while ( $dateTimeStr !~ /(\d{4})\-(\d{1,2})\-(\d{1,2})T(\d{1,2}):(\d{1,2})/ )  {
  say "Please enter a datetime as year-month-dayThour:minutes!" ;
  $dateTimeStr = <STDIN> ;
  chomp $dateTimeStr ;
}
my $dt ;
if ( $dateTimeStr =~ /(\d{4})\-(\d{1,2})\-(\d{1,2})T(\d{1,2}):(\d{1,2})/ ) {
  $dt = DateTime->new( year => $1 , month => $2 , day => $3 , hour => $4 , minute => $5 ) ;
}
say "Please enter a duration in hours ( possibly with a '.' ) !" ;
my $duration = <STDIN> ;
chomp $duration ;
while ( $duration !~ /\A(\d+)\.*/ ) {
  say "Please enter a duration in hours ( possibly with a '.' ) !" ;
}
my $hours ;
my $minutes ;
if ( $duration =~ /\A(\d+)\.*(\d*)\z/ ) {
  $hours = $1 ;
  if ( $2 ) {
      $minutes = $2 ;
  }
}
my $daysLater = int( $duration / 9 ) ; #the normal working day is 9 hours
my $hoursLater = $duration - $daysLater * 24 ;
my $businessDate = $dt->add( days => $daysLater , hours => $hoursLater , end_of_month =>
      'wrap' ) ;
my $weekDay = $dt->day_of_week ;
if ( $weekDay == 6 ) {
  $businessDate->add( days => 2 ) ;
}
if ( $weekDay == 7 ) {
  $businessDate->add( days => 2 ) ;
}
if ( $businessDate->hour + $hoursLater > 18 ) {
  $businessDate->add( days => 1 ) ;
  $weekDay = $businessDate->day_of_week ;
  if ( $weekDay == 6 ) {
      $businessDate->add( days => 2 ) ;
  }
  if ( $weekDay == 7 ) {
      $businessDate->add( days => 2 ) ;
  }
  $businessDate->subtract( minutes => $hoursLater * 60 ) ;
}
say ( $businessDate->ymd . ", " . $businessDate->hms ) ;
