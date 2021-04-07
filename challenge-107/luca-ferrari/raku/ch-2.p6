#!raku


sub MAIN( Str $clazz = 'Rat' ) {
    .say for ::($clazz).^methods( :local ).sort;
}
