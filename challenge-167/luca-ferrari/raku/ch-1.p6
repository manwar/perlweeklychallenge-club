#!raku

# Perl Weekly Challenge 167

sub is-circular-prime( Int $prime )
{
    return False if ! $prime.is-prime;

    my @digits = $prime.comb;
    my $found = True;
    for 1 ..^ @digits.elems {
        return False if ! ( |@digits[ $_ .. * - 1], |@digits[ 0 .. $_ - 1 ] ).join.Int.is-prime;
    }

    return True;
}


sub MAIN() {
    (100 .. 999).grep( { is-circular-prime( $_ ) } ).join( "\n" ).say;
}
