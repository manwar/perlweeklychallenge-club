#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub rotateLeft {
    my $array = shift ;
    my @rotated ;
    my $len = scalar( @$array ) ;
    push( @rotated , $array->[-1] ) ;
    for my $i (0..$len - 2 ) {
        push( @rotated , $array->[$i] ) ;
    }
    return @rotated ;
}

say "Enter a matrix of m x n integers , <return> to end!" ;
my $line = <STDIN> ;
chomp $line ;
my $columns = scalar( split( /\s/ , $line ) ) ;
my @allNumbers ;
while ( $line ) {
    for my $num( split( /\s/ , $line ) ) {
        push( @allNumbers , $num ) ;
    }
    $line = <STDIN> ;
    chomp $line ;
}
say "How many shifts should there be?" ;
my $shifts = <STDIN> ;
chomp $shifts ;
for (0..$shifts - 1 ) {
    @allNumbers = rotateLeft( \@allNumbers ) ;
}
say '(' ;
my $rows = scalar( @allNumbers ) / $columns ;
for my $row (0..$rows - 1 ) {
    say " [" . join( ' ' , @allNumbers[$row * $columns..$row * $columns +
            $columns -1]) . "]" ;
}
say ')' ;
