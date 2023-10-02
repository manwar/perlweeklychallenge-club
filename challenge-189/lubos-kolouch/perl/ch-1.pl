#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub greater_character {
    my ( $array_ref, $target ) = @_;
    my @sorted_array = sort @$array_ref;

    for my $char (@sorted_array) {
        return $char if $char gt $target;
    }

    return $target;    # Return the target character if no greater character is found
}

is( greater_character( [qw/e m u g/], 'b' ), 'e', 'Example 1' );
is( greater_character( [qw/d c e f/], 'a' ), 'c', 'Example 2' );
is( greater_character( [qw/j a r/],   'o' ), 'r', 'Example 3' );
is( greater_character( [qw/d c a f/], 'a' ), 'c', 'Example 4' );
is( greater_character( [qw/t g a l/], 'v' ), 'v', 'Example 5' );

done_testing();
