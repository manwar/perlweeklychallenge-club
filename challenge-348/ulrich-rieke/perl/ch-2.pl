#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max sum) ;

say "Enter a source time!" ;
my $source = <STDIN> ;
chomp $source ;
say "Enter a target time!" ;
my $target = <STDIN> ;
chomp $target ;
my ( $sourcehours , $sourceminutes , $targethours , $targetminutes ) ;
if ( $source =~ /(\d{2}):(\d{2})/ ) {
    ($sourcehours , $sourceminutes ) = ( $1 , $2 ) ;
}
if ( $target =~ /(\d{2})\:(\d{2})/ ) {
    ( $targethours , $targetminutes ) = ($1 , $2 ) ;
}
if ( $targethours < $sourcehours ) {
    $targethours += 24 ;
}
my @ops = (1 , 5 , 15 , 60 ) ;
my @operations ;
my $diffminutes = $targethours * 60 + $targetminutes - ( $sourcehours * 60
        + $sourceminutes ) ;
while ( $diffminutes != 0 ) {
    my @smaller = grep { $_ <= $diffminutes } @ops ;
    my $divisor = max( @smaller ) ;
    push( @operations , int( $diffminutes / $divisor ) ) ;
    $diffminutes -= $divisor * $operations[-1] ;
}
say sum( @operations ) ;
