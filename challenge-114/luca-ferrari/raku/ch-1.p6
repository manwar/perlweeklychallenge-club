#!raku


sub MAIN( Int $N where { $N > 10 } ) {
    say $_ and exit  if $_ == $_.Str.flip.Int for $N ^.. Inf;
}
