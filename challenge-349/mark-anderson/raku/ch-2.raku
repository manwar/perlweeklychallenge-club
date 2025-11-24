#!/usr/bin/env raku
use Test;

nok meeting-point("ULD");
ok  meeting-point("ULDR");
nok meeting-point("UUURRRDDD");
ok  meeting-point("UURRRDDLLL");
ok  meeting-point("RRUULLDDRRUU");  

sub meeting-point($path)
{
    my @path = $path.comb;
    my $bag  = BagHash.new;

    while @path
    {
        $bag.add: @path.shift;
        return True if all .<L> == .<R>, .<U> == .<D> given $bag
    }

    return False
}
