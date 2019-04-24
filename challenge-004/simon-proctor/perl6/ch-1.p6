#!/usr/bin/env perl6
use v6;

sub infix:<///> ( Int() $nu, Int() $de ) { FatRat.new( $nu, $de ) }

sub bbp-digit ( Int $k ) {
    my $k8 = $k*8;
    (1 /// (16 ** $k)) * ((4 /// ($k8 + 1)) - (2 /// ($k8 + 4)) - (1 /// ($k8 + 5)) - (1 /// ($k8+6)));
}

sub calc-pi( Int $num ) {
    my $p = [+] ( 0..$num ).map( &bbp-digit );
    return $p.Str.substr(0,$num+1);
}

#| Calculate PI to a given number of digits 
sub MAIN (
    Int $digits #= Number of digits to calcuate
) {
    say calc-pi( $digits );
}
