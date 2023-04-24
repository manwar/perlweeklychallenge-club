#!/usr/bin/env raku
use Adverb::Eject;
use Test;

is collect-points(2,4,3,3,3,4,5,4,2),                                   23;
is collect-points(1,2,2,2,2,1),                                         20;
is collect-points(1),                                                    1;
is collect-points(2,2,2,1,1,2,2,2),                                     40;
is collect-points(9,1,1,1,35,35,44,1,5,5,2,5,2,5,44,85,7,7,7,85,1,1,1), 91;

sub collect-points(*@a)
{
    sum gather while @a
    {
        my $c = @a.pairs.classify({ .value }, :as{ .key });
        my $p = $c.first({ consecutive(.value) });
        my $a = $p ?? $p.value !! $c{ @a.Bag.minpairs.head.key };

        @a[ $a ]:eject;
        take $a.elems ** 2
    }
}

sub consecutive(@a)
{
    .tail - .head == .end and [<] $_ given @a 
}
