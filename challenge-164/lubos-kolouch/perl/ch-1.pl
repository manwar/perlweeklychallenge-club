package main;
use strict;
use warnings;
use Math::Prime::Util qw/next_prime/;

sub is_palindrome {
    my $what = shift;

    return $what eq reverse $what;
}

sub get_palindrome_numbers {
    my $what  = shift;
    my $prime = 2;

    my @output;

    while ( $prime < 1000 ) {
        push @output, $prime if is_palindrome($prime);
        $prime = next_prime($prime);

    }

    return \@output;

}

use Test::More;

is_deeply(
    get_palindrome_numbers(),
    [   2,   3,   5,   7,   11,  101, 131, 151, 181, 191,
        313, 353, 373, 383, 727, 757, 787, 797, 919, 929
    ]
);

done_testing;
1;
