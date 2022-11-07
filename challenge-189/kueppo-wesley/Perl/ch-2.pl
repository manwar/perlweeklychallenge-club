#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw/for_list/;
use builtin      qw/indexed/;

no warnings 'experimental::builtin';

use Test::More;
use Test::Deep;

sub find_min_slice {
    my $freq;
    my $target = '';

    $freq->{$target}->[ 0 ] = 0;
    foreach my ( $index, $int ) ( indexed @_ ) {
        $freq->{$int}->[ 0 ]++;
        $freq->{$int}->[ 1 ] = $index unless defined $freq->{$int}->[ 1 ];
        $freq->{$int}->[ 2 ] = $index;

        $freq->{$int}->[ 3 ] = 1 + $index - $freq->{$int}->[ 1 ];
        if ( ( $freq->{$int}->[ 3 ] < ( $freq->{$target}->[ 3 ] // -1 ) && $freq->{$int}->[ 0 ] == $freq->{$target}->[ 0 ] )
            || $freq->{$int}->[ 0 ] > $freq->{$target}->[ 0 ] ) {
            $target = $int;
        }
    }

    return [ @_[ $freq->{$target}->[ 1 ] .. $freq->{$target}->[ 2 ] ] ];
}

my @samples = (
    [ qw/1 3 3 2/ ],
    [ qw/1 2 1 3/ ],
    [ qw/1 3 2 1 2/ ],
    [ qw/1 1 2 3 2/ ],
    [ qw/2 1 2 1 1/ ],
);

my $expected = [
    [ qw/3 3/ ],
    [ qw/1 2 1/ ],
    [ qw/2 1 2/ ],
    [ qw/1 1/ ],
    [ qw/1 2 1 1/ ],
];

cmp_deeply( [ map { find_min_slice( @$_ ) } @samples ], $expected, "Were correctly sliced?" );
done_testing( 1 );
