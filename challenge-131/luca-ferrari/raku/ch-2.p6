#!raku

sub MAIN( Str $delimiters where { $delimiters.chars %% 2 },
          Str $needle where { $needle.chars >= 2 } ) {
    my Str @openings;
    my Str @closings;

    for $delimiters.split( '', :skip-empty ) -> $open, $close {
        @openings.push: $open if $needle ~~ / $open /;
        @closings.push: $close if $needle ~~ / $close /;
    }

    @openings.join.say;
    @closings.join.say;

}
