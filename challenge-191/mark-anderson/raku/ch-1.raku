#!/usr/bin/env raku
use Adverb::Eject;
use Test;

nok twice-largest(< 1 2 3 4 >);
ok  twice-largest(< 1 2 0 5 >);
ok  twice-largest(< 2 6 3 1 >);
nok twice-largest(< 4 5 2 3 >);

sub twice-largest(*@a)
{
    my $m := @a.maxpairs.List;
    return False if $m.elems > 1;
    @a[$m.head.key]:eject;
    so all(@a) <= $m.head.value / 2;
}
