#!raku

sub MAIN( Int $N where { $N >= 10 } ) {
    
    my $sum = $N.split( '' ).map( { $_ * $_ } ).sum;
    say 1 and exit if $sum.sqrt == $sum.sqrt.Int;
    say 0;
}
