#!/usr/bin/env raku
use Test;

is pythagoras-multiplied(20), 12;
is pythagoras-multiplied(7),  2;
is pythagoras-multiplied(1),  0;
is pythagoras-multiplied(15), 8;
is pythagoras-multiplied(30), 22;

sub pythagoras-multiplied($num)
{
    my @triples = gather for 2..sqrt($num) -> $m
    {
        for $m-1...1 -> $n
        {
            my $c = $m**2 + $n**2;
            next if $c > $num;
            my $b = 2 * $m * $n;
            my $a = $m**2 - $n**2;
            take ($a,$b,$c) 
        }
    }

    my @primes = (2,3,5,7...$num div 2).grep(*.is-prime);

    my @multiples = gather for @triples -> $triple
    {
        for @primes -> $p
        {
            loop
            {
                my $multiple = $triple >>*>> ($p * ++$);
                last if $multiple.tail > $num;
                take $multiple 
            }
        }
    }

    @triples.append: @multiples;
    @triples.append: @triples>>[1,0,2];
    @triples.unique(with => &[eqv]).elems
}
