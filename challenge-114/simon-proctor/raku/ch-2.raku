#!/usr/bin/env raku

#| Given a number find the next highest number which has the same number of ones in the binary rep
sub MAIN ( Int $N ) {
    my $ones = one-count( $N );
    ($N^..*).first( { $ones == one-count($_) } ).say;
}

sub one-count( Int $n ) { $n.base(2).comb.grep( * == 1 ).elems }
