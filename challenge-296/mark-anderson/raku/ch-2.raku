#!/usr/bin/env raku
use Test;

ok  square(1,2,2,2,1);
nok square(2,2,2,4);
nok square(2,2,2,2,4);
ok  square(3,4,1,4,3,1);

sub square(+@ints)
{
    my $sum = @ints.sum;
    return False unless $sum %% 4;
    return @ints.max <= $sum div 4
}
