#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics 'permutations';
use JSON 'decode_json';

sub flatten_array($list) {
    return map { @$_ } @$list;
}

sub compare_array ( $list1, $list2 ) {
    return join( ' ', @$list1 ) eq join( ' ', @$list2 );
}

sub array_formation( $source, $target ) {
    # Check that a solution is possible
    if (
        not compare_array(
            [ sort { $a <=> $b } flatten_array($source) ],
            [ sort { $a <=> $b } @$target ]
        )
      )
    {
        return 'false';
    }

    # Generate all possible arrangements of the source lists
    my $iter = permutations($source);
    while ( my $perm = $iter->next ) {
        if ( compare_array( [ flatten_array($perm) ], $target ) ) {
            # It matches the target
            return 'true';
        }
    }

    # No arrangement will match the target
    return 'false';
}

sub main () {
    # Convert the first argument into a list of lists of integers
    my $source = decode_json( $ARGV[0] );
    # Convert the remaining arguments into integers
    my $target = [ @ARGV[ 1 .. $#ARGV ] ];

    my $result = array_formation( $source, $target );
    say $result;
}

main();
