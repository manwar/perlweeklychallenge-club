#!/usr/bin/env raku
use Test;

is-deeply line-counts(([~] "a".."z"),              10 xx 26), (  3,  60);
is-deeply line-counts("bbbcccdddaaa",      flat 4, 10 xx 25), (  2,   4);
is-deeply line-counts(([~] "a".."z"),               1 xx 26), (  1,  26);
is-deeply line-counts(([~] "a".."z"),             100 xx 26), ( 26, 100);
is-deeply line-counts("theweeklychallenge" x 267,     1..26), (534,  92);

sub line-counts($str, @widths)
{
    my @str = $str.comb;

    my %m is Map = "a".."z" Z=> @widths;

    my @lines = do while @str
    {
        my $k = ([\+] %m{@str}).first(* > 100, :k) // @str.elems;
        @str.splice(0, $k) 
    }

    @lines.elems, [+] %m{|@lines.tail}
}
