#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

# Or just:
# perl -MList::MoreUtils=zip -E '@a = qw( 1 2 3 ); @b = qw( a b c ); say for zip @a, @b'

sub zip {
    my ( $input1, $input2 ) = @_;
    my @zipped;

    for ( 0 .. $#$input1 ) {
        push @zipped, ( $input1->[$_], $input2->[$_], );
    }

    @zipped;
}

my @cases = (
    {
        name    => "Zip 123 with abc",
        input_1 => [qw( 1 2 3 )],
        input_2 => [qw( a b c )],
        output  => [qw( 1 a 2 b 3 c )],
    },
    {
        name    => "Zip abc with 123",
        input_1 => [qw( a b c )],
        input_2 => [qw( 1 2 3 )],
        output  => [qw( a 1 b 2 c 3 )],
    },
);

for ( @cases ) {
    is_deeply( [ zip( $_->{input_1}, $_->{input_2} ) ],
        $_->{output}, $_->{name} );
}

done_testing();
