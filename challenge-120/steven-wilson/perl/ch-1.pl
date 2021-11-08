#!/usr/bin/env perl
# TASK #1 > Swap Odd/Even bits

use strict;
use warnings;
use feature qw/ say /;
use Test::More;

ok( swap_odd_even_bits(101) == 154, 'Input: $N = 101 Output: 154' );
ok( swap_odd_even_bits(18) == 33,   'Input: $N = 18 Output: 33' );
done_testing();

sub swap_odd_even_bits {
    my $input   = shift;
    my $binary  = sprintf( "%08b", $input );
    my $swapped = join( "", map { scalar reverse $_ } $binary =~ m/..?/g );
    return oct( "0b" . $swapped );
}
