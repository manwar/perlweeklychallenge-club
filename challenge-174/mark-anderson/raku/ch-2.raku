#!/usr/bin/env raku
use Test;

is permutation2rank([0,1,2]),                0;
is permutation2rank([1,0,2]),                2; 
is permutation2rank([2,1,0]),                5;
is permutation2rank([4,0,5,2,1,3]),          500; 
is permutation2rank([1,3,2,5,6,0,4]),        1000; 
is permutation2rank([3,2,6,0,5,1,4]),        2500; 
is permutation2rank([6,7,3,4,1,2,0,5]),      35000; 
is permutation2rank([6,9,0,1,3,4,7,8,2,5]),  2500000; 

is-deeply rank2permutation([0..2], 0),       (0,1,2);
is-deeply rank2permutation([0..2], 2),       (1,0,2);
is-deeply rank2permutation([0..2], 5),       (2,1,0);
is-deeply rank2permutation([0..5], 500),     (4,0,5,2,1,3);
is-deeply rank2permutation([0..6], 1000),    (1,3,2,5,6,0,4);
is-deeply rank2permutation([0..6], 2500),    (3,2,6,0,5,1,4);
is-deeply rank2permutation([0..7], 35000),   (6,7,3,4,1,2,0,5);
is-deeply rank2permutation([0..9], 2500000), (6,9,0,1,3,4,7,8,2,5);

sub postfix:<!>($n) { [*] 1..$n }

sub permutation2rank(@n)
{
    @n = @n.kv.map(-> $k, $v { + grep { $v > $_ }, @n[$k..*] });
    [+] (@n Z (@n.end...0)).map({ .[0] * .[1]! });
}

sub rank2permutation(@n, $rank is copy)
{
    gather while @n 
    {
        my $f = @n.end!;
        my $i = ($f, $f*2 ... *).first({ $_ > $rank }, :k);
        take @n[$i];
        $rank -= $i * $f;
        @n = @n[0..^$i, $i^..*].flat;
    }
}
