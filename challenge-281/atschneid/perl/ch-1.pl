use warnings;
use strict;

use List::Util qw(sum);

use v5.38;

my @inputs = ("a1", "f1", "d8");
for (@inputs) {
    say $_ . ' => ' . ( check_square($_) ? 'true' : 'false' );
}

sub check_square( $key ) {
    return sum( map { ord($_) } split '', $key ) % 2;
}
