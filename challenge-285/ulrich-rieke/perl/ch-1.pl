#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some routes ( start and destination separated by blank)!" ;
say "Enter routes by ','!" ;
my $line = <STDIN> ;
chomp( $line ) ;
my @routes = split( /\,/ , $line ) ;
my %routepairs ;
for my $route ( @routes ) {
   my ( $start , $destination ) = split( /\s/ , $route ) ;
   $routepairs{$start} = $destination ;
}
say join( ',' , grep { not ( exists( $routepairs{$_} ) ) } values 
      %routepairs ) ;
