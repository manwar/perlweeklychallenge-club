#!/usr/bin/env raku
use Test;

ok  buddy-strings("fuck", "fcuk");
nok buddy-strings("love", "love");
ok  buddy-strings("fodo", "food");
ok  buddy-strings("feed", "feed");

sub buddy-strings($s, $t)
{
    given $s.comb >>eq<< $t.comb
    {
        return $s.comb.Bag.values.any >= 2 if .all;

        given .grep(*.not, :k)
        {
            return False unless .elems == 2;

            return $s.substr(.[0], 1) ~ $s.substr(.[1], 1) eq
                   $t.substr(.[1], 1) ~ $t.substr(.[0], 1) 
        }
    }
}
