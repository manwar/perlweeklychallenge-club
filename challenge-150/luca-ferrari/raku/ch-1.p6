#!raku

sub MAIN( Str $a, Str $b where { $a.chars == $b.chars && $a ~~ / ^ <[0 .. 9]>+ $ / && $b ~~ / ^ <[0 .. 9]>+ $ / } ) {
    my @fibonacci-words = $a, $b;
    for 0 .. Inf{
        @fibonacci-words.push: @fibonacci-words[ * - 2 ] ~ @fibonacci-words[ * - 1 ];
        @fibonacci-words[ * - 1 ].substr( @fibonacci-words[ * - 1 ].chars - 2, 1 ).say and last if @fibonacci-words[ * - 1 ].chars - 1 == 51;
    }

    @fibonacci-words.join( "\n" ).say;
}
