#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use DateTime ;

my %temperatures ;
open ( my $fh , '< temperature.txt' ) or die "Can't open temperatures.txt!" ;
while ( my $line = <$fh> ) {
  chomp $line ;
  my ( $date , $temperature ) = split( /,/ , $line ) ;
  $temperature =~ s/\A(\s*)(\d+)\z/$2/ ;
  $temperatures{ $date } = $temperature ;
}
close( $fh ) ;
my @dates ;
for my $date ( keys %temperatures ) {
  my ($year , $month , $day ) = split( /\-/ , $date ) ;
  my $dt = DateTime->new( year => $year , month => $month , day => $day )  ;
  push @dates , $dt ;
}
my @orderedDates = sort { $a->year <=> $b->year || $a->month <=> $b->month
  || $a->day <=> $b->day } @dates ;
for my $i ( 1 .. scalar( @orderedDates ) - 1 ) {
  if ( $temperatures{ $orderedDates[$i]->ymd } >
    $temperatures{ $orderedDates[ $i - 1 ]->ymd } ) {
      say $orderedDates[$i]->ymd ;
  }
}
