use strict;
use warnings;
use Math::Prime::Util qw/is_prime/;

sub get_pernicious {
    my $what = shift;

    my @nums;

    my $num = 0;
    while ( scalar @nums < $what ) {
        $num++;
        my $bin_num = sprintf( "%b", $num );
        $bin_num =~ s/0//g;
        push @nums, $num if is_prime( length($bin_num) );
    }

    return \@nums;
}

use Test::More;
is_deeply( get_pernicious(10), [ 3, 5, 6, 7, 9, 10, 11, 12, 13, 14 ] );
done_testing;
