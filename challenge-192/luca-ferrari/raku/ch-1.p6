#!raku

# Perl Weekly Challenge 192

sub MAIN( Int $n where { $n > 0 } ) {
    $n.base(2).comb.map( { $_ == 0 ?? 1 !! 0 } ).join.parse-base(2).say;
}
