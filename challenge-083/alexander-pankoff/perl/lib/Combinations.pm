package Combinations;
use strict;
use warnings;
use feature qw(signatures);
no warnings 'experimental::signatures';

use Exporter qw(import);

our @EXPORT_OK = qw(combinations);

# returns possible combinations of $length elements from @pool.
sub combinations ( $count, @pool ) {
    return () if $count == 0 || $count > @pool;
    return map { [$_] } @pool if $count == 1;

    my @combinations;
    while ( @pool && $count <= @pool ) {
        my $elem = shift @pool;
        my @sub_combinations = combinations( $count - 1, @pool );
        push @combinations, map { [ $elem, @$_, ] } @sub_combinations;
    }

    return @combinations;
}

1;
