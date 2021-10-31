#!raku

sub MAIN( Int $m where { $m > 0 }, Int $n where { $n > 0 } ) {
    ( [gcd] $m, $n ) %% 2 ?? '1'.say !! '0'.say;
}
