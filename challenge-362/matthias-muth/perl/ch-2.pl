#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 362 Task 2: Spellbound Sorting
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use Lingua::Any::Numbers qw( to_string +locale );

sub spellbound_sorting( @input ) {
    state %minus = ( EN => "minus ", FR => "moins " );
    my $minus = $minus{ uc $ENV{LANGUAGE} } // $minus{'EN'};
    return map $_->[0],
        sort { $a->[1] cmp $b->[1] }
            map [ $_, ( $_ < 0 ? $minus : "" ) . to_string( abs( $_ ) ) ],
                @input;
}

use Test2::V0 qw( -no_srand );

is [ spellbound_sorting( 6, 7, 8, 9, 10 ) ], [ 8, 9, 7, 6, 10 ],
    'Example 1: spellbound_sorting( 6, 7, 8, 9, 10 ) => (8, 9, 7, 6, 10)';
is [ spellbound_sorting( -3, 0, 1000, 99 ) ], [ -3, 99, 1000, 0 ],
    'Example 2: spellbound_sorting( -3, 0, 1000, 99 ) => ( -3, 99, 1000, 0 )';

{
    local $ENV{LANGUAGE} = "fr";
    is [ spellbound_sorting( 1, 2, 3, 4, 5 ) ], [ 5, 2, 4, 3, 1 ],
        'Example 3 (FR):'
            . ' spellbound_sorting( 1, 2, 3, 4, 5 ) => ( 5, 2, 4, 3, 1 )';
}

is [ spellbound_sorting( 1, 2, 3, 4, 5 ) ], [ 5, 4, 1, 3, 2 ],
    'Example 3: spellbound_sorting( 1, 2, 3, 4, 5 ) => ( 5, 4, 1, 3, 2 )';
is [ spellbound_sorting( 0, -1, -2, -3, -4 ) ], [ -4, -1, -3, -2, 0 ],
    'Example 4: spellbound_sorting( 0, -1, -2, -3, -4 ) => (-4, -1, -3, -2, 0)';
is [ spellbound_sorting( 100, 101, 102 ) ], [ 100, 101, 102 ],
    'Example 5: spellbound_sorting( 100, 101, 102 ) => (100, 101, 102)';
{
    local $ENV{LANGUAGE} = "fr";
    is [ spellbound_sorting( -1, 0, 1 ) ], [ -1, 1, 0 ],
        'Own Test 1 (FR):'
            . ' spellbound_sorting( -1, 0, 1 ) => ( -1, 1, 0 )';
}
done_testing;

sub Xtranslate_fr( $n ) {
    state @tr = (
        [ qw( zero un deux trois quatre cinq six sept huit neuf
                dix onze douze treize quatorze quinze seize ) ],
        [ qw( - dix vingt trente quarante cinquante
                soixante - quatre-vingt - ) ],
        [ qw( cent ) ],
        [ qw( mille ) ],
        [ qw( million ) ],
        [ qw( milliard ) ],
    );

    return "moins " . translate_fr( abs( $n ) )
        if $n < 0;
    return
        $n < 20 ? $tr[0][$n] // $tr[1][1] . "-" . $tr[0][ $n - 10 ] :
        $n < 60 ? $tr[1][ $n / 10 ]
                    . ( $n % 10 != 0
                        ? ( $n % 10 == 1 ? " et " : "-" )
                            . $tr[0][ $n % 10 ]
                        : "" ) :
        $n < 100 ? $tr[1][ int( $n / 20 ) * 2 ]
                    . ( $n % 20 != 0
                        ? ( $n < 80 && $n % 10 == 1 ? " et " : "-" )
                        . ( $tr[0][ $n % 20 ]
                            // ( $tr[1][1]
                                . "-" . $tr[0][ $n % 20 - 10 ] ) )
                        : "" ) :
        $n < 1000 ? ( $n >= 200 ? $tr[0][ $n / 100 ] . " " : "" )
                    . $tr[2][0]
                    . ( $n % 100 != 0
                        ? " " . translate_fr( $n % 100 )
                        : "" ) :
        $n < 1000000 ?
                    ( $n >= 2000
                        ? translate_fr( int( $n / 1000 ) ) . " " : "" )
                    . $tr[3][0]
                    . ( $n % 1000 != 0
                        ? " " . translate_fr( $n % 1000 )
                        : "" ) :
        $n < 1000000000 ?
                    translate_fr( int( $n / 1000000 ) ) . " "
                    . $tr[4][0]
                    . ( $n % 1000000 != 0
                        ? " " . translate_fr( $n % 1000000 )
                        : "" ) :
        $n < 1000000000000 ?
                    translate_fr( int( $n / 1000000000 ) ) . " "
                    . $tr[5][0]
                    . ( $n % 1000000000 != 0
                        ? " " . translate_fr( $n % 1000000000 )
                        : "" )
                : "too big"
} 

__END__
for ( -2..121, 198..202, 998..1002, 999999..1000002, 999999999..1000000002,
    999999999999..1000000000002 )
{
    say $_, "\t", to_string( $_ );
}
exit 0;
