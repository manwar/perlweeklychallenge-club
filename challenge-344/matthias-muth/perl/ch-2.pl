#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 344 Task 2: Array Formation
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );

use List::Util qw( all );

sub array_starts_with( $try, $target ) {
    return $try->@* <= $target->@*
        && all { $target->[$_] eq $try->[$_] } keys $try->@*;
}

# The available source sequences are distributed into buckets.
# Each bucket contains all source sequences that have the same first element.
# That first element is used as the 'label' of the bucket.
# For example, if the target is ( 5, 8, 2, 9, 1 ), obviously the first source
# sequence that matches needs to have a 5 as the first element.
# We therefore only need to consider the source sequences in the bucket
# labeled '5'.
sub can_be_formed( $buckets, $target ) {
    my $bucket_label = $target->[0];

    # Check whether there are matching pieces to try.
    return false
        if ! exists $buckets->{$bucket_label};

    # Try the pieces in the bucket in turn.
    for ( keys $buckets->{$bucket_label}->@* ) {
        my $try = $buckets->{$bucket_label}[$_];

        next unless array_starts_with( $try, $target );

        # We have a match. Let's see what remains to do.
        my $new_target = [ $target->@[ $try->$#* + 1 .. $target->$#* ] ];

        # We found a complete match if the target is fully covered.
        return true
            if $new_target->@* == 0;

        # There still is something left to do.
        # Build a new bucket list without the source sequence that we
        # just used.
        # All other buckets can be copied as shallow copies.
        # The current bucket needs to be recreated with a copy of all
        # source sequences except the current one.
        my %new_buckets = $buckets->%*;
        $new_buckets{$bucket_label} = [
            $buckets->{$bucket_label}->@[
                0 .. $_ - 1,
                $_ + 1 .. $buckets->{$bucket_label}->$#*,
            ]
        ];

        # Recursive call for matching the rest.
        return true
            if can_be_formed( \%new_buckets, $new_target );
    }
    return false;
}

sub array_formation( $source, $target ) {
    my %buckets;
    push $buckets{$_->[0]}->@*, $_
        for $source->@*;
    return can_be_formed( \%buckets, $target );
}

use Test2::V0 qw( -no_srand );

is array_formation( [[2, 3], [1], [4]], [1 .. 4] ), T,
    'Example 1: array_formation( [[2, 3], [1], [4]], [1 .. 4] ) is true';
is array_formation( [[1, 3], [2, 4]], [1 .. 4] ), F,
    'Example 2: array_formation( [[1, 3], [2, 4]], [1 .. 4] ) is false';
is array_formation( [[9, 1], [5, 8], [2]], [5, 8, 2, 9, 1] ), T,
    'Example 3: array_formation( [[9, 1], [5, 8], [2]], [5, 8, 2, 9, 1] ) is true';
is array_formation( [[1], [3]], [1, 2, 3] ), F,
    'Example 4: array_formation( [[1], [3]], [1, 2, 3] ) is false';
is array_formation( [[7, 4, 6]], [7, 4, 6] ), T,
    'Example 5: array_formation( [[7, 4, 6]], [7, 4, 6] ) is true';

is array_formation(
    [ [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] ],
    [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ] ), T,
    'Own Example 1: 1 to 12';

done_testing;
