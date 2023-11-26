#!/usr/bin/env raku
use Test;
use Benchy;

is-deeply count-smaller(8,1,2,2,3), (4,0,1,1,3);
is-deeply count-smaller(6,5,4,8),   (2,1,0,3);
is-deeply count-smaller(2,2,2),     (0,0,0);

benchmark();

sub count-smaller(*@a)
{
    my $b = @a.Bag;
    map { [+] $b{^$_} }, @a 
}

sub count-smaller-slow(*@a)
{
    map { + @a.grep(* < $_) }, @a
}

sub benchmark
{
    my @a = (^1000).roll(10000);

    b 2, 
    { gist count-smaller-slow(@a) }, 
    { gist count-smaller(@a) }

    # Old:  5.12986256s
    # New:  0.445446281s
    # NEW version is 11.52x faster
}
