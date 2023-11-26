#!/usr/bin/env raku
use Test;
use Benchy;

is-deeply flip-matrix(<1 1 0>, <1 0 1>, <0 0 0>),
    ((1,0,0), (0,1,0), (1,1,1))>>.Seq;

is-deeply flip-matrix(<1 1 0 0>, <1 0 0 1>, <0 1 1 1>, <1 0 1 0>),
    ((1,1,0,0), (0,1,1,0), (0,0,0,1), (1,0,1,0))>>.Seq;

benchmark();

sub flip-matrix(+@m)
{
    map -> $r { map -> $c { @m[$r;$c] +^ 1 }, (@m.end...0) }, ^@m
}

sub flip-matrix-slow(+@m)
{
    map { reverse $_ >>+^>> 1 }, @m
    
    # no difference in time
    # map { .[.end...0] >>+^>> 1 }, @m
}

sub benchmark
{
    my @m = map { (0,1).roll(100_000) }, ^100_000;

    b 10, { flip-matrix-slow(@m) }, { flip-matrix(@m) }

    # Old:  3.332146938s
    # New:  0.8259856s
    # NEW version is 4.03x faster
}
