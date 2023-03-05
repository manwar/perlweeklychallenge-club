sub task1 (@hhmm --> UInt) {
    return @hhmm
        .map({ .[0] * 60 + .[1]       given .split(':')   })
        .combinations(2)
        .map({ ( $_, 1440 - $_ ).min  given abs [-] .list })
        .min;
}


constant @tests =
    ( <00:00 23:55 20:00>       ,  5 ),
    ( <01:01 00:50 00:57>       ,  4 ),
    ( <10:10 09:30 09:00 09:55> , 15 ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is task1($in), $expected;
}
