#!/usr/bin/env raku
use Adverb::Eject;
use Test;

is max-pairs(<ab de ed bc>),       1;
is max-pairs(<aa ba cd ed>),       0;
is max-pairs(<uv qp st vu mn pq>), 2;

sub max-pairs(*@words)
{
    + do while @words
    { 
        my $w = @words.pop;
        my $k = @words.first(* eq $w.flip, :k);
        @words[$k]:eject with $k
    }
}
