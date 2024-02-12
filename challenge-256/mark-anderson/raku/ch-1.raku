#!/usr/bin/env raku
use Test;

is max-pairs(<ab de ed bc>),       1;
is max-pairs(<aa ba cd ed>),       0;
is max-pairs(<uv qp st vu mn pq>), 2;

# Credit to Niels van Dijke (PerlBoy1967) for this algorithm.

sub max-pairs(*@words)
{
    my $bh = BagHash.new;

    + gather for @words
    { 
        .take if $bh{$_};
        $bh.add(.flip)
    }
}
