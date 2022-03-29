package main;

use strict;
use warnings;

use Math::NumberBase;

sub is_brazilian {
    my ($what) = shift;

    my $base_10 = Math::NumberBase->new(10);

    for my $i ( 2 .. $what - 2 ) {
        my $base = Math::NumberBase->new($i);

        my $base_rep = $base_10->convert_to( $what, $base );
        return 1 if $base_rep =~ /^(.)\1+$/msx;
    }

    return 0;
}

use Test::More;

is( is_brazilian(7), 1, 'Test 7' );
is( is_brazilian(6), 0, 'Test 6' );
is( is_brazilian(8), 1, 'Test 8' );
done_testing;

1;
