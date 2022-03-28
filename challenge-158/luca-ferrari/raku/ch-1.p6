#!raku
sub MAIN( Int $limit where { $limit > 0 } = 100 ) {
    ( 1 .. $limit ).grep( *.is-prime ).grep( *.comb.sum.is-prime ).say;
}
