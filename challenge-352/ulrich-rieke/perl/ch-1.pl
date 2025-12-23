#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub contains {
    my $array = shift ;
    my $element = shift ;
    for my $word( @$array ) {
        if ( $word eq $element ) {
            return 1 ;
        }
    }
    return 0 ;
}

say "Enter some words separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my @result ;
for my $word ( @words ) {
    my @selected = grep { $_ ne $word && $_ =~ /$word/ } @words ;
    if ( @selected ) {
        unless ( contains( \@result , $word ) ) {
            push( @result , $word ) ;
        }
    }
}
say '(' . join( ',' , @result ) . ')' ;

