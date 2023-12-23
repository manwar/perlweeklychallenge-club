use strict;
use warnings;
use Test::More tests => 2;

sub shortest_distance {
    my ( $s, $char ) = @_;
    my @positions = grep { substr( $s, $_, 1 ) eq $char } 0 .. length($s) - 1;
    return map {
        my $i   = $_;
        my $min = List::Util::min map { abs( $i - $_ ) } @positions
    } 0 .. length($s) - 1;
}

# Tests
is_deeply(
    [ shortest_distance( "loveleetcode", "e" ) ],
    [ 3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0 ]
);
is_deeply( [ shortest_distance( "aaab", "b" ) ], [ 3, 2, 1, 0 ] );
