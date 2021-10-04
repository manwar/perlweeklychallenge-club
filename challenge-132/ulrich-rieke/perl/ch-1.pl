#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use DateTime ;

say "Please enter your birthdate in the form <year/month/day>" ;
my $birthdate = <STDIN> ;
chomp $birthdate ;
while ( $birthdate !~ /(\d{4})\/(\d{2})\/(\d{2})/ ) {
  say "Please enter your birthdate as <year/month/day>" ;
  $birthdate = <STDIN> ;
  chomp $birthdate ;
}
if ( $birthdate =~ /(\d{4})\/(\d{2})\/(\d{2})/ ) {
  my $today = DateTime->today ;
  my $bd = DateTime->new( year => $1 ,
              month => $2 ,
              day => $3 ,
              time_zone => 'UTC' ) ;
  $today->set_time_zone( 'floating' ) ;
  $bd->set_time_zone( 'floating' ) ;
  my $days_alive = $today->delta_days( $bd ) ;
  my $mirrorBefore = $bd - $days_alive ;
  my $mirrorAfter = $today + $days_alive ;
  say $mirrorBefore->ymd('/') . ", " . $mirrorAfter->ymd('/') ;
}
