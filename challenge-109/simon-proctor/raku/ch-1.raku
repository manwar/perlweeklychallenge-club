#!/usr/bin/env raku

#| Give the Chowla number up to X (default 20)
sub MAIN ( Int \X = 20 ) {
    (1..X).map( { chowla($_) } ).join(",").say;
}

sub chowla($x) {
    [+] (2..^$x).grep( $x %% * );
}
