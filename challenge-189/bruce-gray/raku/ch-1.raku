sub task1 ( @a, Str $target --> Str ) {
    return .elems ?? .min !! $target given @a.grep( * gt $target );

    # Single-pass too-clever alternative:
    # return @a.min({ $_ !gt $target, $_ }) max $target;
}


my @tests =
    ( <e m u g>, 'b', 'e' ),
    ( <d c e f>, 'a', 'c' ),
    ( <j a r  >, 'o', 'r' ),
    ( <d c a f>, 'a', 'c' ),
    ( <t g a l>, 'v', 'v' ),
    ;
use Test;
plan +@tests;
for @tests -> ( @array, $target,  $expected ) {
    is task1(   @array, $target), $expected, "task1(<@array[]>)";
}
