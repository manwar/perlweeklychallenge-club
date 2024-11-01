#!/usr/bin/env raku
use Adverb::Eject;
use Test;

is similar-dominos([1,3],[3,1],[2,4],[6,8]),             2;
is similar-dominos([1,2],[2,1],[1,1],[1,2],[2,2]),       3;
is similar-dominos([1,2],[2,1],[3,5],[1,2],[2,2],[5,3]), 5;

sub similar-dominos(+@dominos)
{
    sum gather while @dominos
    {
        my @m = @dominos.grep(@dominos[0] (==) *, :k);
        take .elems if .end given @m;
        @dominos[@m]:eject
    }
}
