#!/usr/bin/env raku
use Test;

is-deeply merge-accounts([ 
                           [<A a1@a.com a2@a.com>],
                           [<B b1@b.com>],
                           [<A a3@a.com a1@a.com>] 
                         ]),
                         [ 
                           [<A a1@a.com a2@a.com a3@a.com>],
                           [<B b1@b.com>]
                         ];

is-deeply merge-accounts([ 
                           [<A a1@a.com a2@a.com>],
                           [<B b1@b.com>],
                           [<A a3@a.com>],
                           [<B b2@b.com b1@b.com>] 
                         ]),
                         [
                           [<A a1@a.com a2@a.com>],
                           [<A a3@a.com>],
                           [<B b1@b.com b2@b.com>]
                         ];;

is-deeply merge-accounts([
                           [<C c2@c.com>],
                           [<C c1@c.com c4@c.com>], 
                           [<A a1@a.com a2@a.com>],
                           [<B b1@b.com>],
                           [<A a3@a.com>],
                           [<B b4@b.com b5@b.com b6@b.com>],
                           [<C c1@c.com c3@c.com>],
                           [<B b2@b.com b1@b.com>],
                           [<A a3@a.com a4@a.com>],
                           [<B b3@b.com>];
                         ]),
                         [
                           [<A a1@a.com a2@a.com>],
                           [<A a3@a.com a4@a.com>],
                           [<B b4@b.com b5@b.com b6@b.com>],
                           [<B b1@b.com b2@b.com>],
                           [<B b3@b.com>],
                           [<C c2@c.com>],
                           [<C c1@c.com c3@c.com c4@c.com>]
                         ];

sub merge-accounts(@accounts)
{
    my @a = @accounts.classify({ .[0] }, :as{ .[1..*] });

    .Array given gather for @a.sort(*.key)  
    {
        my @value = .value>>.Array;

        while @value.shift -> @v
        {
             my $k = @value.first({ $_ (&) @v }, :k);
             $k.defined ?? (@value[$k] = [(@value[$k] (|) @v).keys]) 
                        !! take [(.key, @v.sort.Slip)];
        }
    }  
}
