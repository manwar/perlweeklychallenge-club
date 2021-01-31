#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(sum0 min);

{
    my $B = '101100101';
    my $S = 3;

    my @bit_strings = chunks_of( $S, split( '', $B ) );
    use Data::Dumper;
    print Dumper \@bit_strings;

    # get groups of pairings for each bit_string with each other bit_string
    my @pairing_groups = pair_groups( @bit_strings );

    # and calculate the total number of flips required for each group
    my @total_flipping_distances =
      map {
        sum0( map { flip_distance( @{$_} ) } @$_ )
      } @pairing_groups;

    # the minimum of these totals is our result
    say min( @total_flipping_distances );

}

# returns the number of elements in $b that have to be flipped to make it the
# same as $a
sub flip_distance ( $a, $b ) {
    sum0( map { $a->[$_] != $b->[$_] } 0 .. $#{$a} );
}

# returns a list of pairings for each element in @xs
sub pair_groups(@xs) {

    # generate all possible pairs in all permutations
    my @all_pairs = permutations( 2, @xs );

    # in a list with @xs elements there will be (@xs-1) pairs for each element.
    # with the permutations beeing ordered, we can split it up into (@xs-1)
    # sized chunks, to get a group with pairs for the first element, a group
    # with pairs for the second element, and so on
    my @pairings = chunks_of( @xs - 1, @all_pairs );
    return @pairings;
}

# splits a list into chunks of size $size
sub chunks_of ( $size, @xs ) {
    return if !@xs;
    my $chunk = [ @xs[ 0 .. min( ( $size - 1 ), $#xs ) ] ];
    return ( $chunk, chunks_of( $size, @xs[ $size .. $#xs ] ) );
}

# generates all permutations of size $size from list @xs
# permutations will be generated in the same order as the input elements
sub permutations ( $size, @xs ) {
    return map { [$_] } @xs if $size <= 1;

    my @out;
    for my $index ( 0 .. $#xs ) {
        my @rest = @xs[ grep { $_ != $index } 0 .. $#xs ];
        for my $perm ( permutations( $size - 1, @rest ) ) {
            push @out, [ $xs[$index], @$perm ];
        }
    }

    return @out;
}
