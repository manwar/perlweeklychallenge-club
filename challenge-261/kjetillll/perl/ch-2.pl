use strict; use warnings;

sub f {
    my $n = pop;
    grep( $_ == $n, @_ ) ? f( @_, $n*2 ) : $n
}

use Test::More tests => 3;
is( f( @{ $$_{input} }, $$_{start} ), $$_{output} ) for
    {
        input  => [5,3,6,1,12],
        start  => 3,
        output => 24},
    {
        input  => [1,2,4,3],
        start  => 1,
        output => 8
    },
    {
        input  => [5,6,7],
        start  => 2,
        output => 2
    };
