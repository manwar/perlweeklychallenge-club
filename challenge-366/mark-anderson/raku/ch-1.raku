#!/usr/bin/env raku
use Test;

is count-prefixes(< a ap app apple banana >,              "apple"),   4;
is count-prefixes(< cat dog fish >,                       "bird"),    0;
is count-prefixes(< hello he hell heaven he >,            "hello"),   4;
is count-prefixes((Empty.Str, < code coding cod >).flat,  "coding"),  3;
is count-prefixes(< p pr pro prog progr progra program >, "program"), 7;

sub count-prefixes(@a, $s)
{
    @a.grep({ $s.starts-with($_) }).elems
}
