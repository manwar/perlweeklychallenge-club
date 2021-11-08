#!raku


sub MAIN( Str $time where { $time ~~ / ^ \d ** 2 ':' \d ** 2 $ / } ) {
    my ( $hour, $minute ) = $time.split( ':', :skip-empty );

    $hour   %= 12;
    $minute %= 60;
    $minute /= 5;

    say abs( $hour - $minute ) * 30;
}
