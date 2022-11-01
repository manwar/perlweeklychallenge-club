#!raku


sub MAIN( Str $k, *@letters ) {
    @letters.grep( $k le * ).sort.head.say;

}
