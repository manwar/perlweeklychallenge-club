use strict;
use warnings;

use Algorithm::Combinatorics qw/combinations/;
use List::MoreUtils qw(uniq);

sub get_integers {
    my ( $what, $divisor ) = @_;

    my @unique = uniq split '', $what;

    my $result;

    for my $i ( 1 .. scalar @unique - 1 ) {
        my @combinations = combinations( \@unique, $i );

        for my $comb (@combinations) {
            my $num = join '', @$comb;
            $result++ if $num % $divisor == 0;
        }

    }

    return $result;

}

use Test::More;

is( get_integers( 1234, 2 ), 9 );
is( get_integers( 768,  4 ), 3 );

done_testing;
