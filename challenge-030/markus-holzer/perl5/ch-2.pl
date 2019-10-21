use Modern::Perl;
use List::Util qw( sum );
use Set::Product qw( product );
use Algorithm::Combinatorics qw( variations_with_repetition );

product {
    my ( $even, $rest ) = @_;

    say join( ", ", $even, @$rest )
        if sum( $even, @$rest ) == 12;
}
[ 2, 4 .. 10 ],
[ variations_with_repetition( [1 .. 10], 2 ) ];

