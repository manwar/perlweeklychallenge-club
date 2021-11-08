#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $T = $ARGV[0] ;
my ( $hours , $minutes ) = split( /:/ , $T ) ;
my $hourPosition = 360 / 12 * ($hours % 12 ) + 30 / 60 * $minutes ;
my $minutesPosition = 360 / 60 * $minutes ;
my $max = $hourPosition > $minutesPosition ? $hourPosition :
$minutesPosition ;
my $min = $hourPosition > $minutesPosition ? $minutesPosition :
$hourPosition ;
say $max - $min . " degrees" ;
