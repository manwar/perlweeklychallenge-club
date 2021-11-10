#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use DateTime ;

my $year = $ARGV[ 0 ] ;
while ( $year !~ /\A\d{4}\z/ ) {
  say "Please enter a year with 4 digits!" ;
  $year = <STDIN> ;
  chomp $year ;
}
my $weekdays = 0 ;
my $dt = DateTime->new(
      year => $year ,
      month => 1 ,
      day => 1
      ) ;
while ( $dt->year == $year ) {
  unless ( $dt->day_of_week == 6 || $dt->day_of_week == 7 ) {
      $weekdays++ ;
  }
  $dt->add( days => 1 ) ;
}
say $weekdays ;
