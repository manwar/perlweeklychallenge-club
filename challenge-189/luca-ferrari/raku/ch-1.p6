#!raku


sub MAIN( Str $k, *@letters ) {
    for @letters.sort -> $current {
        $current.say and exit if $k le $current;
    }
}
