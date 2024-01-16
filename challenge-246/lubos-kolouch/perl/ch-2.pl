use strict;
use warnings;

sub is_linear_recurrence {
    my @a = @_;

    # Need at least 5 elements to form two equations and solve for p and q
    return 0 if @a < 5;

    # Forming two equations:
    # a[2] = p * a[0] + q * a[1]
    # a[3] = p * a[1] + q * a[2]
    # And solving for p and q
    my $denominator = $a[0] * $a[2] - $a[1]**2;
    return 0 if $denominator == 0;    # Avoid division by zero

    my $p = ( $a[2] * $a[3] - $a[1] * $a[4] ) / $denominator;
    my $q = ( $a[4] - $p * $a[2] ) / $a[3];

    # Check if p and q are integers
    return 0 if $p != int($p) || $q != int($q);

    # Verify the recurrence for the rest of the array
    for my $i ( 4 .. $#a ) {
        return 0 if $a[$i] != $p * $a[ $i - 2 ] + $q * $a[ $i - 1 ];
    }

    return 1;
}

# Tests
use Test::More tests => 3;
ok( is_linear_recurrence( 1,  1, 2, 3,  5 ), 'Fibonacci sequence' );
ok( !is_linear_recurrence( 4, 2, 4, 5,  7 ), 'Even-odd mismatch' );
ok( is_linear_recurrence( 4,  1, 2, -3, 8 ), 'Custom sequence' );

# Main
print is_linear_recurrence( 4, 1, 2, -3, 8 ) ? "true\n" : "false\n";
