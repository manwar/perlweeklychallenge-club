#!/usr/bin/env raku

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is smaller-than(6, 5, 4, 8), (2, 1, 0, 3);
    is smaller-than(7, 7, 7, 7), (3, 3, 3, 3);
    is smaller-than(5, 4, 3, 2, 1), (4, 3, 2, 1, 0);
    is smaller-than(-1, 0, 3, -2, 1), (1, 2, 4, 0, 3);
    is smaller-than(0, 1, 1, 2, 0), (1, 3, 3, 4, 1);
    done-testing;    
}

sub smaller-than( *@vals ) {
    return @vals.map( -> $v { state $i //=-1; $i++; @vals[0..^$i,$i^..*].flat.grep(* <= $v).elems; } );
}

multi sub MAIN(*@args where all(@args) ~~ Int()) {
    smaller-than(|@args).join(",").say;
}
