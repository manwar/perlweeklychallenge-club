#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @sorted = sort { $a <=> $b } split( /\s/ , $line ) ;
my $len = scalar( @sorted ) ;
my @neighbours ;
for my $i ( 0..$len - 2) {
    for my $j( $i + 1 .. $len - 1) {
        push( @neighbours , [$sorted[$i] , $sorted[$j]] ) ;
    }
}
my $mindiff = min( map { $_->[1] - $_->[0] } @neighbours ) ;
my @result = grep { $_->[1] - $_->[0] == $mindiff } @neighbours ;
print "[" ;
for my $pair( @result ) {
    print '(' . $pair->[0] . ',' . $pair->[1] . ")," ;
}
say "]" ;
      
