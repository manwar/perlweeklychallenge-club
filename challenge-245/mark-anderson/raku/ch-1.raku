#!/usr/bin/env raku
use Test;

is-deeply sort-lang(<perl c python>,    [2,1,3]), <c perl python>;
is-deeply sort-lang(<c++ haskell java>, [1,3,2]), <c++ java haskell>;

sub sort-lang(@languages, @popularities)
{
    .[@popularities] given [Any, |@languages]
}
