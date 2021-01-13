#!/usr/bin/env raku

sub left-rotate ( @a, @b ) {
    @b.map: { @a.rotate: $_ }
}

multi MAIN ( :$test! ) {
    use Test;
    cmp-ok left-rotate( <10 20 30 40 50>, <3 4> ),'~~', (<40 50 10 20 30>, <50 10 20 30 40>);
    cmp-ok
        left-rotate( <7 4 2 6 3>, <1 3 4> ),
        '~~',
        (
            <4 2 6 3 7>,
            <6 3 7 4 2>,
            <3 7 4 2 6>,
        );
    done-testing;
}
