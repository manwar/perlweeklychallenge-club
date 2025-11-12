#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub handleRest {
    my $rest = shift ;
    my $len = length $rest ;
    my $result ;
    if ( $len == 2 || $len == 3) {
        $result = $rest ;
    }
    else {
        $result = substr( $rest , 0 , 2 ) . '-' . substr( $rest , 2 ) ;
    }
    return $result ;
}

sub printParts {
    my $parts = shift ;
    if ( scalar( @$parts ) == 1 ) {
        say $parts->[0] ;
    }
    else {
        say join( '-' , @$parts ) ;
    }
}

say "Enter a telephone number containing digits , space and dash only!" ;
my $phonenumber = <STDIN> ;
chomp $phonenumber ;
$phonenumber =~ s/(\s|\-)//g ;
my $len = length $phonenumber ;
if ( $len <= 4 ) {
    say handleRest( $phonenumber ) ;
}
else {
    my @parts ;
    my $partnumber = int( $len / 3 ) ;
    my $lengthrest = $len % 3 ;
    if ( $lengthrest != 0 && $lengthrest < 2 ) {
        $partnumber-- ;
    }
    my $pos = 0 ;
    my $i = 0 ;
    while ( $i < $partnumber ) {
        push( @parts , substr( $phonenumber , $pos , 3 ) ) ;
        $pos += 3  ;
        $i++ ; 
    }
    my $restlen = $len - $partnumber * 3 ;
    if ( $restlen == 0 ) {
        printParts( \@parts ) ;
    }
    else {
        my $rest = substr( $phonenumber , $partnumber * 3 ) ;
        push( @parts , handleRest( $rest )) ;
        printParts( \@parts ) ;
    }
}
