#!/usr/bin/env raku
use Test;

is single-common-word(<apple banana cherry>, <banana cherry date>), 2;
is single-common-word(<a ab abc>, <a a ab abc>),                    2;
is single-common-word(<orange lemon>, <grape melon>),               0;
is single-common-word(<test test demo>, <test demo demo>),          0;
is single-common-word(<Hello world>, <hello world>),                1;

sub single-common-word(@a, @b)
{
    .elems given (@a (-) @a.repeated) (&) (@b (-) @b.repeated)
}
