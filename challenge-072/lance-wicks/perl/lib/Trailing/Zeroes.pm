package Trailing::Zeroes;

use List::Util qw(reduce);
use Moo;

# TODO Handle any number not just zero

sub factorial {
    my ( $self, $n ) = @_;

    return reduce { $a * $b } 1 .. $n;
}

sub count {
    my ( $self, $number ) = @_;
    $number =~ /(0+)$/;
    return length($1) || 0;
}

1;

