#!/usr/bin/env raku
use Test;

is last-member(2,7,4,1,8,1), 1;
is last-member(1),           1;
is last-member(1,1),         0;

sub last-member(+@a)
{
    @a .= sort(-*);

    loop
    {
        return @a if @a == 1;
        return 0  if @a == 2;

        my $diff = [-] @a.splice(0, 2);

        if $diff
        {
            my $i = @a.first({ $_ <= $diff }, :k) // @a.elems;
            @a.splice($i, 0, $diff)
        }
    }
}
