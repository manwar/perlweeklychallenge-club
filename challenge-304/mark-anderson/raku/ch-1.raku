#!/usr/bin/env raku
use Test;

ok  arrange-binary([1,0,0,0,1], 1);
nok arrange-binary([1,0,0,0,1], 2);
nok arrange-binary([0,0,0,1,0,0,0,0,1,0,0], 4);
nok arrange-binary([0,0,0,1,0,0,0,1,0,0,0], 4);
ok  arrange-binary([0,0,0,1,0,0,0,1,0,0,0], 3);
nok arrange-binary([0,0,1,0,0,0,0,1,0,0,0], 3);

sub arrange-binary(@ints, $n)
{
    return False unless @ints.join ~~ m:g/00/ >= $n;
    my $even = @ints.first(1,:k) %% 2;
    my @mask = (flat $even ?? (0,1) xx * !! (1,0) xx *).head(@ints);
    return not @mask.join.parse-base(2) +& @ints.join.parse-base(2)
}
