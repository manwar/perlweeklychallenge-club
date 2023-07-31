#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use DateTime ;

say "Please enter a year from 1853 to 9999!" ;
my $year = <STDIN> ;
chomp $year ;
my $sum = 0 ;
for my $m (1..12) {
   my $dt = DateTime->new(
	 year => $year , 
	 month => $m , 
	 day   => 13 , 
	 hour  => 0 , 
	 minute => 0 , 
	 second => 0 , 
	 nanosecond => 0 , 
	 time_zone => 'Asia/Taipei' , 
	 ) ;
   if ( $dt->day_of_week == 5 ) {
      $sum++ ;
   }
}
say "The number of Friday 13th in $year is $sum!" ;
