sub task2 ( Str $prefix, @words --> UInt ) {
    return +grep *.starts-with($prefix, :ignorecase), @words;
}


constant @tests = map { Hash.new: <expected in> Z=> .list },
    ( 2, ( 'at', <pay attention practice attend> ) ),
    ( 3, ( 'ja', <janet julia java javascript>   ) ),
;
use Test;
plan +@tests;
is task2(|.<in>), .<expected> for @tests;
