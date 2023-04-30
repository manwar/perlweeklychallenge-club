#!/usr/bin/env perl

use v5.36;
use strict;
use warnings;

use experimental 'switch';

use List::Util qw( first );

sub get_position ( $n, @numbers ) {
    return ( first( sub { $numbers[$_] == $n }, keys(@numbers) ) ) + 1;
}

sub replace_position ($position) {
    given ($position) {
        when ( $_ == 1 ) { return 'G' }
        when ( $_ == 2 ) { return 'S' }
        when ( $_ == 3 ) { return 'B' }
        default          { return $position }
    }
}

sub rank_score (@numbers) {
    my @sorted_numbers = sort( { $b <=> $a } @numbers );
    my @ranks          = map( get_position( $_, @sorted_numbers ), @numbers );
    my @result         = map( &replace_position($_),               @ranks );
    return \@result;
}

#| Run test cases
sub main() {

    use Test2::V0 qw( is plan );

    plan 4;

    is rank_score( 1, 2, 4, 3, 5 ), [ 5, 4, 'S', 'B', 'G' ],
      'works for (1,2,4,3,5)';
    is rank_score( 8, 5, 6, 7, 4 ), [ 'G', 4, 'B', 'S', 5 ],
      'works for (8,5,6,7,4)';
    is rank_score( 3, 5, 4, 2 ), [ 'B', 'G', 'S', 4 ], 'works for (3,5,4,2)';
    is rank_score( 2, 5, 2, 1, 7, 5, 1 ), [ 4, 'S', 4, 6, 'G', 'S', 6 ],
      'works for (2,5,2,1,7,5,1)';
}

main();
