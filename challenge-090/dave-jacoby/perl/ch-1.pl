#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

my $sequence =  'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG' ;
my $complement = $sequence;
$complement =~ tr/TACG/ATGC/;

say <<"END";
    Sequence:   $sequence
    Complement: $complement
END

for my $i ( qw( A T C G ) ) {
    my $n = scalar grep {/$i/} split // , $sequence;
    say qq(    $i: $n );
}


