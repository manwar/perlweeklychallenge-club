#!/usr/bin/perl ;
use strict ;
use warnings ;
use DateTime ;

my @dates ;
for my $year (2019..2100) {
  my $date = DateTime->new( year => $year , month => 12 , day => 25 ) ;
  if ( $date->day_of_week == 7 ) {
      push( @dates , $date ) ;
  }
}
print "These are the Christmas days on a Sunday:\n" ;
map {print $_->ymd . "\n"} @dates ;
