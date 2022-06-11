#!raku

sub MAIN( Int $n where { $n > 0 } ) {
    '1'.say and exit if $n.comb.map( { $_ <= 1 ?? 1 !! [*] 1 .. $_ } ).sum == $n;
    '0'.say;
}
