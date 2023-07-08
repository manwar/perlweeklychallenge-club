use strict;
use warnings;

sub dot_product {
    my ( $a, $b ) = @_;
    my $dot_product = 0;
    for my $i ( 0 .. $#$a ) {
        $dot_product += $a->[$i] * $b->[$i];
    }
    return $dot_product;
}

my @a = ( 1, 2, 3 );
my @b = ( 4, 5, 6 );
print dot_product( \@a, \@b );    # Output: 32
