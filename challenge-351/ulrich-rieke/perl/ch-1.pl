#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum max min all ) ;

sub find {
    my $array = shift ;
    my $element = shift ;
    my $pos = 0 ;
    while ( $array->[$pos] != $element ) {
        $pos++ ;
    }
    return $pos ;
}

say "Enter some numbers separated by blanks!" ;
my $numberline = <STDIN> ;
chomp $numberline ;
my @numbers = split ( /\s/ , $numberline ) ;
if ( all { $_ == $numbers[0] } @numbers ) {
    say 0 ;
}
else {
    my $maxi = max( @numbers ) ;
    my $pos = find( \@numbers , $maxi ) ;
    splice( @numbers , $pos , 1 ) ;
    my $mini = min( @numbers ) ;
    $pos = find( \@numbers , $mini ) ;
    splice( @numbers , $pos , 1 ) ;
    say ( sum( @numbers) / scalar( @numbers ) ) ;
}
