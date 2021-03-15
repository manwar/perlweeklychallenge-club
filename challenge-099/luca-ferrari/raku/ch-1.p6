#!raku

sub MAIN( Str $S, Str $P ) {
    # substitute every ? to match a single char
    # and every * to match a stream of chars
    # and add anchors
    my $regexp = '^' ~ $P.subst( '*', '.*' ).subst( '?', '.' ) ~ '$';
    { say 1; exit; } if $S ~~ / <$regexp> /;
    say 0;
}
