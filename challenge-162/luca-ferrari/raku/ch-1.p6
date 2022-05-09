#!raku

sub MAIN( Str $isbn where { $isbn.chars == 12 && $isbn.comb.grep( * ~~ / <[0 .. 9]> / ).elems == $isbn.chars } ) {
    my $position = 0;
    say 10 - ( $isbn.comb.map( { $_ * ( ++$position %% 2 ?? 3 !! 1 ) } ).sum % 10 );
}
