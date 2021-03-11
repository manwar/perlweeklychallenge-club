#!/usr/bin/perl ;
use strict ;
use warnings ;
use List::Util qw( sum ) ;
use feature 'say' ;

my $starttime = $ARGV[0] ;
my $currenttime = $ARGV[1] ;
my $file = $ARGV[2] ;
my @playtimes ; #for the lengths of the titles
my @titles ; #for the titles
open my $fh , "<" , $file or die "Can't open file $file!\n" ;
while ( my $line = <$fh> ) {
  chomp $line ;
  my ( $playlength , $title ) = split( /,/ , $line ) ;
  push @playtimes, $playlength ;
  push @titles, $title ;
}
close $fh ;
my $totalplaytime = sum @playtimes ;
my $time_passed = ($currenttime - $starttime) * 1000 ;
my $total_playcycles = int ( $time_passed / $totalplaytime );
my $time_left = $time_passed - ( $total_playcycles * ($totalplaytime) ) ;
#convert $time_left to milliseconds ;
my $i = 0 ;
my $sumtime = 0 ;
$sumtime += $playtimes[ $i ] ;
while ( $sumtime < $time_left ) {
  $i++ ;
  $sumtime += $time_left ;
}
my $remainder ;
if ( $i > 0 ) {
  $remainder = $sumtime - sum @playtimes[0..$i] ;
}
else { #$i == 0
  $remainder = $sumtime ;
}
say $titles[ $i ] ;
