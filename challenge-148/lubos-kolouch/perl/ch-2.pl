use strict;
use warnings;
use Math::Complex;

sub generate_cardano_triplets {
    my $n = shift;
    my @triplets;
    my $a = 1;

    while ( @triplets < $n ) {
        for my $b ( 0 .. $a ) {
            next unless $b % 2 == 0;    # b is even
            for my $c ( 1 .. $a ) {
                next unless $c % 2 != 0;    # c is odd
                my $val = cbrt( $a + $b * $c**2 ) + cbrt( $a - $b * $c**2 );
                if ( abs( $val - 1 ) < 1e-10 ) {
                    push @triplets, [ $a, $b, $c ];
                    last if @triplets == $n;
                }
            }
        }
        $a += 2;    # a is odd
    }

    return @triplets;
}

my @triplets = generate_cardano_triplets(5);
for my $triplet (@triplets) {
    print join( ", ", @$triplet ), "\n";
}
