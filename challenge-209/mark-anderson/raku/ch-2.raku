#!/usr/bin/env raku

merge-accounts([ 
                 ["A", "a1@a.com", "a2@a.com"],
                 ["B", "b1@b.com"],
                 ["A", "a3@a.com", "a1@a.com"] 
               ]);

merge-accounts([ 
                 ["A", "a1@a.com", "a2@a.com"],
                 ["B", "b1@b.com"],
                 ["A", "a3@a.com"],
                 ["B", "b2@b.com", "b1@b.com"] 
               ]);

merge-accounts([
                 ["C", "c2@c.com"],
                 ["C", "c1@c.com", "c4@c.com"], 
                 ["A", "a1@a.com", "a2@a.com"],
                 ["B", "b1@b.com"],
                 ["A", "a3@a.com"],
                 ["C", "c1@c.com", "c3@c.com"],
                 ["B", "b2@b.com", "b1@b.com"],
                 ["A", "a3@a.com", "a4@a.com"],
                 ["B", "b3@b.com"];
               ]);

sub merge-accounts(@accounts)
{
    my @a = @accounts.classify({ .[0] }, :as{ .[1..*] });

    for @a.sort(*.key)  
    {
        my $key   = .key;
        my @value = .value>>.Array;

        my @g = gather
        {
            while @value
            {
                my @v := @value.shift;
                my $k = @value.first({ $_ (&) @v }, :k);
                $k.defined ?? @value[$k].append(@v) .= unique !! take @v;
            }
        }

        say $key => @g>>.sort;
    }
}
