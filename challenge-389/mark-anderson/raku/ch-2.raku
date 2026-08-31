#!/usr/bin/env raku
use MONKEY-SEE-NO-EVAL;
use Test;

is ZigZag(9,4,2,10,7,8,8,1,9), 5;
is ZigZag(1,7,4,9,2,5),        6;
is ZigZag(1,2,3,4,5),          2;
is ZigZag(4,4,4),              1;
is ZigZag(10,20,15,12,18),     3;

sub ZigZag(*@a)
{
    my @r = @a.rotor(2 => -1);
    
    return max f((('<', '>') xx *).flat), 
               f((('>', '<') xx *).flat);

    sub f(@a)
    {
        my $e = (@a Z @r).subst(/(.) \s (\d+) \s (\d+)/, {"$1 $0 $2,"}, :g);
       (EVAL $e).join.comb(/'True'+/) andthen .elems ?? .max.chars div 4 + 1 !! 1 
    }
}
