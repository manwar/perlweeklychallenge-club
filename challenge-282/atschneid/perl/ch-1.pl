use strict;
use warnings;

use v5.38;

sub good_integer( $int ) {
    my @val = $int =~ /((\d)(?!\g-1)|(^))((\d)\g-1{2})(?!\g-1)/g;
    if (@val) {
	my @retval;
	my $idx = 3;
	while ($idx <= $#val) {
	    push @retval, $val[$idx];
	    $idx += 5;
	}
	return @retval;
    }
    return (-1);
}

sub good_integer_v2( $int ) {
    my @val = grep { 3 == length $_ } $int =~ /((\d)\g-1*)/g;
    if (@val) {
	return @val;
    }
    return (-1);
}

my @inputs = (
    12333,
    12333455557,
    1233345557,
    1233333,
    333,
    3331,
    3333
    );
for (@inputs) {
    say $_ . ' => ' . join ', ', good_integer( $_ );
    say $_ . ' => ' . join ', ', good_integer_v2( $_ );
}
