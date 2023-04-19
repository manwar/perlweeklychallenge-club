#!/usr/bin/env raku
use Test;

is-deeply fun-sort(1,2,3,4,5,6),       (2,4,6,1,3,5);
is-deeply fun-sort(1,2),               (2,1);
is-deeply fun-sort(1),                 (1,);
is-deeply fun-sort(1,2,3,4,5,6,4,5,6), (2,4,4,6,6,1,3,5,5);

sub fun-sort(*@a)
{
    my %c = @a.classify({ $_ %% 2 ?? 'even' !! 'odd' });
    flat (%c<even> || Empty, %c<odd> || Empty)>>.sort
}
