#!/usr/bin/env raku
use Adverb::Eject;
use Test;

is collect-points(<2 4 3 3 3 4 5 4 2>),                                23;
is collect-points(<1 2 2 2 2 1>),                                      20;
is collect-points(1),                                                   1;
is collect-points(<2 2 2 1 1 2 2 2>),                                  40;
is collect-points(<1 1 1 25 3 25 3 25 44 9 25 44 25 5 25 5 25 1 1 1>), 92;

sub collect-points(*@a)
{
    sum gather while @a
    {
        my $c = @a.pairs.classify({ .value }, :as{ .key });
        my $p = $c.first({ consecutive(.value) });

        if $p
        { 
            take $p.value.elems ** 2
        }

        else 
        {
            $p = $c.classify({ .key }, :as{ .value.elems }).minpairs.head;
            take $p.value.Slip
        }
            
        @a[ $c{$p.key} ]:eject
    }
}

sub consecutive(@a)
{
    .tail - .head == .end and [<] $_ given @a 
}
