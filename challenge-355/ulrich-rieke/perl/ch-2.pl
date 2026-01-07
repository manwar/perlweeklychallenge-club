#!usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all max ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $result = "false" ;
my $len = scalar( @numbers ) ;
if ( $len < 3 ) {
    $result = "false" ;
}
else {
    my $maxint = max( @numbers ) ;
    my $maxpos ; #where do we find the maximum number ?
    for my $i ( 0..$len - 1) {
        if ( $numbers[$i] == $maxint ) {
            $maxpos = $i ;
            last ;
        }
    }
    if ( $maxpos == 0 || $maxpos == $len - 1 ) {
        $result = "false" ;
    }
    else {
        my @risingDifferences ;
        for my $i (0..$maxpos - 1) {
            push( @risingDifferences , $numbers[$i] - $numbers[$i + 1] ) ;
        }
        my @fallingDifferences ;
        for my $i ($maxpos..$len - 2) {
            push( @fallingDifferences , $numbers[$i] - $numbers[$i + 1] ) ;
        }
        if ( (all { $_ < 0 } @risingDifferences) &&
                (all { $_ > 0 } @fallingDifferences) ){
            $result = "true" ;
        }
    }
}
say $result ;
