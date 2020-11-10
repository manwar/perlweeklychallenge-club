#!/usr/bin/perl
use warnings;
use strict;

use constant {
    MAX_INT32 => (unpack 'l', pack 'H8', 'ffffff7f'),
    MIN_INT32 => (unpack 'l', pack 'H8', '00000080'),
};

sub inverse_integer {
    my ($int) = @_;
    my $r = reverse $int;
    $r =~ s/^0+//;
    substr $r, 0, 0, '-' if $r =~ s/-$//;

    return 0
        if $r > MAX_INT32 || $r < MIN_INT32;

    return $r
}

use Test::More tests => 8;

is inverse_integer(1234), 4321, 'Example 1';
is inverse_integer(-1234), -4321, 'Example 2';
is inverse_integer(1231230512), 0, 'Example 3';

is inverse_integer(7463847412), MAX_INT32, 'maxint32';
is inverse_integer(8463847412), 0, 'maxint+1';
is inverse_integer(-8463847412), MIN_INT32, 'minint32';
is inverse_integer(-9463847412), 0, 'minint-1';
is inverse_integer(9e14), 9, 'remove zeroes';

=for comment

But this breaks:

  is inverse_integer(1e15), 1, 'verylong';

It's unclear what the "given integer" means.

=cut
