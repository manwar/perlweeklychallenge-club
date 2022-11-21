#!/usr/bin/env perl
package challenge191::ch1;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use List::Util qw(reduce);

use Test::More tests => 8;

is( twice_largest( [ 1, 2, 3, 4 ] ), -1, "Example 1" );
is( twice_largest( [ 1, 2, 0, 5 ] ), 1,  "Example 2" );
is( twice_largest( [ 2, 6, 3, 1 ] ), 1,  "Example 3" );
is( twice_largest( [ 4, 5, 2, 3 ] ), -1, "Example 4" );

is( twice_largest_reduce( [ 1, 2, 3, 4 ] ), -1, "Example 1" );
is( twice_largest_reduce( [ 1, 2, 0, 5 ] ), 1,  "Example 2" );
is( twice_largest_reduce( [ 2, 6, 3, 1 ] ), 1,  "Example 3" );
is( twice_largest_reduce( [ 4, 5, 2, 3 ] ), -1, "Example 4" );

# using sort
sub twice_largest ($xs) {
    return 1 if @$xs < 2;
    my @sorted      = sort { $b <=> $a } (@$xs);
    my $max         = $sorted[0];
    my $next_to_max = $sorted[1];

    return $max >= $next_to_max * 2 ? 1 : -1;
}

# with a single iteration of the input list
sub twice_largest_reduce ($xs) {
    return 1 if @$xs < 2;
    my $maximums = reduce(
        sub {
            if ( !defined $a->{max} || $b >= $a->{max} ) {
                $a->{next_to_max} = $a->{max};
                $a->{max}         = $b;
                return $a;
            }
            if ( !defined $a->{next_to_max} || $b > $a->{next_to_max} ) {
                $a->{next_to_max} = $b;
                return $a;
            }

            return $a;

        },
        { max => undef, next_to_max => undef },
        @$xs
    );

    return $maximums->{max} >= $maximums->{next_to_max} * 2 ? 1 : -1;

}
