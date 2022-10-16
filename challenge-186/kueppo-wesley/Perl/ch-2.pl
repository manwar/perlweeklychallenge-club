#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use Test::More;

use Encode;
use Unicode::Normalize;

sub makeover {
    my $string = $_[ 0 ];

    # Decompose unicode characters based on *Compatibility Equivalence* to obtain the
    # ascii characters for which impurities have been added to build unicode $string.
    $string = NFKD( $string );

    # Change $string' encoding to ASCII
    $string = encode(
        'ascii',
        $string,

        # Strip the impurities
        sub { '' }
    );

    return $string;
}

# Testing..
is( makeover( 'ÃÊÍÒÙ' ), 'AEIOU', "is 'AEIOU' its ascii equivalence?" );
is( makeover( 'âÊíÒÙ' ), 'aEiOU', "is 'aEiOU' its ascii equivalence?" );

done_testing( 2 );
