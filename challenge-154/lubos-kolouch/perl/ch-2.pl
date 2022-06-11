use strict;
use warnings;
use Math::Prime::XS qw/is_prime/;

my @nums_cache = ( 1, 1, 1 );
my %seen_nums;

sub gen_next_num {
    push @nums_cache, $nums_cache[-2] + $nums_cache[-3];
}

sub get_n_unique {
    my $what    = shift;
    my $counter = 0;
    my @output;

    while ( $counter < $what ) {
        gen_next_num;

        next unless is_prime( $nums_cache[-1] );
        next if $seen_nums{ $nums_cache[-1] };
        push @output, $nums_cache[-1];
        $counter++;
        $seen_nums{ $nums_cache[-1] } = 1;
    }

    return \@output;
}

use Test::More;

is_deeply( get_n_unique(10), [ 2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057 ] );

done_testing;
