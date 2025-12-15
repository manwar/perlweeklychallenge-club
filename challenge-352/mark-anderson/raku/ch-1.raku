#!/usr/bin/env raku
use Test;

is-deeply match-string(< cat cats dog dogcat dogcat rat ratcatdogcat >), < cat dog dogcat rat >;
is-deeply match-string(< hello hell world wor ellow elloworld >),        < hell world wor ellow >;
is-deeply match-string(< a aa aaa aaaa >),                               < a aa aaa >;
is-deeply match-string(< flower flow flight fl fli ig ght >),            < flow fl fli ig ght >;
is-deeply match-string(< car carpet carpenter pet enter pen pent >),     < car pet enter pen pent >;
is-deeply match-string(< catcat cat dog dogdog >),                       < cat dog >;

sub match-string(@words)
{
    @words.unique.grep(-> $w { @words ~~ m:2nd/$w/ })
}
