use strict;
use warnings;
use Test::More tests => 3;

sub count_smaller {
    my @nums = @_;
    my @result;

    for my $i ( 0 .. $#nums ) {
        my $count = 0;
        for my $j ( 0 .. $#nums ) {
            $count++ if $nums[$j] < $nums[$i] && $j != $i;
        }
        push @result, $count;
    }

    return @result;
}

# Tests
is_deeply( [ count_smaller( 8, 1, 2, 2, 3 ) ], [ 4, 0, 1, 1, 3 ], 'Example 1' );
is_deeply( [ count_smaller( 6, 5, 4, 8 ) ],    [ 2, 1, 0, 3 ],    'Example 2' );
is_deeply( [ count_smaller( 2, 2, 2 ) ],       [ 0, 0, 0 ],       'Example 3' );
