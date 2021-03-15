#!raku


sub MAIN( Int :$N = 1 ) {
    say ~$N == ~$N.flip ?? '1' !! '0';
}
