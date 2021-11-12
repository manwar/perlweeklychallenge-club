#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use DateTime ;

my @longYears ;
for my $year ( 1900..2100 ) {
  my $dt = DateTime->new(
    year => $year ,
    month => 12 ,
    day => 31 ,
    hour => 0 ,
    minute => 0 ,
    second => 0 ,
    nanosecond => 0 ,
    time_zone => 'America/Chicago') ;
  if ( $dt->week_number == 53 ) {
      push @longYears, $year ;
  }
}
my $start = 0 ;
my $len = scalar @longYears ;
while ( $start +5 <= $len ) {
  say join( ", " , @longYears[$start .. $start + 4]) . ", " ;
  $start += 5 ;
}
say join(", " , @longYears[$start .. $len -1] ) ;
