use strict;
use warnings;
use feature 'say';

sub smaller_than_current {
    my (@ints) = @_;
    return map { my $x = $_; scalar grep { $_ < $x } @ints } @ints;
}

# Test cases
use Test::More tests => 4;
is_deeply([smaller_than_current(5, 2, 1, 6)], [2, 1, 0, 3]);
is_deeply([smaller_than_current(1, 2, 0, 3)], [1, 2, 0, 3]);
is_deeply([smaller_than_current(0, 1)], [0, 1]);
is_deeply([smaller_than_current(9, 4, 9, 2)], [2, 1, 2, 0]);
