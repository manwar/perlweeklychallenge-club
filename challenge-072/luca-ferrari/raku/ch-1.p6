#!raku


sub MAIN( Int $N where { 0 < $N <= 10 } ) {
    my $factorial = [*] 1 .. $N;
    my $zeros = $factorial ~~ / 0+ $ /;
    "$N ! = $factorial and has { $zeros.chars } trailing zeros".say;
}
