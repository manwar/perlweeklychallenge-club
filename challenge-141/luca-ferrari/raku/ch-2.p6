#!raku

sub MAIN( Int $m, Int $n ) {
    $m.comb.combinations( 1 ..^ $m.Str.chars ).map( *.join.Int ).grep( * %% $n ).unique.sort.say;

}
