#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my $len = length $word ;
my $count = 0 ;
for my $i (0..$len - 3 ) {
    my %uniques ;
    map { $uniques{$_}++ } split( // , substr( $word , $i , 3 ) ) ;
    if ( scalar( keys %uniques ) == 3 ) {
        $count++ ;
    }
}
say $count ;
