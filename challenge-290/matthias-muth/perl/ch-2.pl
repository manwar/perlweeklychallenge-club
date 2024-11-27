#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 290 Task 2: Luhn’s Algorithm
#
#       Perl solution by Matthias Muth.
#
#
# Several different solutions!
#

use v5.20;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';


#
#   luhn_s_algorithm_by_module
#
#   Using the Algorithm::LUHN CPAN module.
#

use Algorithm::LUHN qw( is_valid );

sub luhn_s_algorithm_by_module( $input ) {
    return is_valid( $input =~ s/\D//gr );
}


#
#   luhn_s_algorithm_classic
#
#   Extracting the digits, separating the check digit,
#   then walking through the digits in a loop.
#   Taking a 'perlish' approach for doing the digit sum of doubled digits.
#
#   Hold your breath, this is not the final version!
#
sub luhn_s_algorithm_classic( $input ) {

    # Extract the digits into an array.
    my @digits = $input =~ /\d/g;

    # Return if there are no digits.
    @digits or return;

    # Extract the check-digit.
    my $check_digit = pop @digits;

    # Reverse the digit array to process the digits in the suggested order.
    @digits = reverse @digits;

    # Determine the checksum in a loop.
    my $checksum = 0;
    for my $index ( 0..$#digits ) {
        $checksum +=
            ( $index % 2 == 0 )
            ? sum( split "", 2 * $digits[$index] )
            : $digits[$index];
    }

    # Return true if the difference between the checksum and the next
    # number divisible by 10 is equal to the check-digit.
    return ( 10 - $checksum % 10 ) % 10 == $check_digit;
}


#
#   luhn_s_algorithm_optimized
#
#   Algorithmic simplifications:
#   - summing up *including* the check-digit, the total sum modulo 10
#     must then be zero,
#   - using a simplified, numeric formula for the digit sum of
#     doubled digits (less function calls, less type conversions).
#
sub luhn_s_algorithm_optimized( $input ) {

    # Extract the digits into an array.
    # Return if there are no digits.
    my @digits = reverse $input =~ /\d/g
        or return;

    # Determine the checksum in a loop.
    # Note the swapped even/odd cases, because we include the check digit
    # on index 0.
    my $checksum = 0;
    for my $index ( 0..$#digits ) {
        $checksum +=
            ( $index % 2 != 0 )
            ? $digits[$index] <=4 ? ( $digits[$index] * 2 ) : ( $digits[$index] * 2 - 9 )
            : $digits[$index];
    }

    # Return true if the checksum, including the check digit,
    # is divisible by 10.
    return $checksum % 10 == 0;
}

# For the following implementation, we need at least Perl v5.36
# for the multi-variable 'for' loop and the 'indexed' builtin.
if ( $^V >= v5.36 ) {
    eval <<'EOF';

    use builtin qw 'indexed';
    no warnings 'experimental';

    #
    #   luhn_s_algorithm_modern
    #
    #   Algorithmic simplifications as before.
    #   Using 'modern' Perl features:
    #   - using 'indexed' builtin to add indices to the digits,
    #   - processed by a multi-variable for-loop.
    #
    sub luhn_s_algorithm_modern( $input ) {
        my @digits = reverse( $input ) =~ /\d/g
            or return;
        my $checksum = 0;
        for my ( $index, $digit ) ( indexed @digits ) {
            $checksum +=
                $index % 2 == 0
                ? $digit
                : $digit <= 4 ? ( 2 * $digit ) : ( 2 * $digit ) - 9;
        }
        return $checksum % 10 == 0;
    }
EOF
    $@ and die $@;
}

#
#   luhn_s_algorithm_using_pairmap
#
#   Using 'sum' and 'pairmap' to compute the checksum,
#   making even/odd computations unneccessary.
#   We need to make sure that we have an even number of digits,
#   so we add a '0' if necessary.
#   The digits will be $a and $b inside the pairmap code block.
#

use List::Util qw( sum pairmap );

sub luhn_s_algorithm_using_pairmap( $input ) {
    my @digits = reverse $input =~ /\d/g
        or return;
    @digits % 2 == 0 or push @digits, 0;
    my $checksum =
        sum( pairmap {
                $a + ( $b <= 4 ? ( 2 * $b ) : ( 2 * $b ) - 9 )
            } @digits );
    return $checksum % 10 == 0;
}

#
#   Experimental zone:
#   Doing array lookups instead of computing the doubled digit digit sum.
#   Actually *slower* than the numerical computations!
#
use List::Util qw( sum );

use constant DOUBLES => ( 0, 2, 4, 6, 8, 1, 3, 5, 7, 9 );

sub luhn_s_algorithm_using_digit_lookups( $input ) {
    my @digits = reverse $input =~ /\d/g
        or return;
    my $index = 0;
    return sum( map { $index++ % 2 ? (DOUBLES)[$_] : $_ } @digits ) % 10 == 0;
}

sub luhn_s_algorithm_using_digit_lookups_pairmap( $input ) {
    my @digits = reverse $input =~ /\d/g
        or return;
    @digits % 2 == 0 or push @digits, 0;
    return sum( pairmap { $a + (DOUBLES)[$b] } @digits ) % 10 == 0;
}


use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

=for original
ok luhn_s_algorithm( "17893729974" ),
    'Example 1: luhn_s_algorithm( 17893729974 ) is true';
ok luhn_s_algorithm( "4137 8947 1175 5904" ),
    'Example 2: luhn_s_algorithm( "4137 8947 1175 5904" ) is true';
ok ! luhn_s_algorithm( "4137 8974 1175 5904" ),
    'Example 3: luhn_s_algorithm( "4137 8974 1175 5904" ) is false';

done_testing;
=cut

use constant { false => !1, true => !0 };
my $sub_name = "luhn_s_algorithm";

#
#   Flexible testing.
#
=for testing
my $extras = 0;
my @tests = (
    [ 'Example 1:', 17893729974, true ],
    [ 'Example 2:', "4137 8947 1175 5904", true ],
    [ 'Example 3:', "4137 8974 1175 5904", false ],
    map( [ 'Extra ' . ++$extras . ':', $_, true ],
	"4242 4242 4242 4242",
	"00", "18", "26", "34", "42", "59", "67", "75", "83", "91",
        "0" ),
    map( [ 'Extra ' . ++$extras . ':', $_, false ],
        1..9, "" )
);

use feature 'postderef';
no warnings 'experimental::postderef';

# This runs the tests not only for the sub named "$sub_name",
# but also for all variants with any suffix ("$subname<suffix>").
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    note "\n", "Testing $sub:\n", "\n";
    for ( @tests ) {
        my ( $descr, $input, $output ) = $_->@*;
        $descr .= " $sub( " . pp( $input ) . " ) is "
	    . ( $output ? 'true' : 'false' )
            if substr( $descr, -1, 1 ) eq ":";
        no strict 'refs';
	$output
	? ok( $sub->( $input ), $descr )
	: ok( ! $sub->( $input ), $descr );
    }
}

done_testing;
=cut

# =for benchmark
#
#   Benchmarks.
#

use Benchmark qw( cmpthese );

my %run_for = map { $_ => 1 } qw(
    luhn_s_algorithm_classic
    luhn_s_algorithm_by_module
    luhn_s_algorithm_using_pairmap
    luhn_s_algorithm_modern
);

my $input = 17893729974;
my %runs;
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    next unless $run_for{$sub};
    my $id = $sub =~ s/^luhn_s_algorithm_(?:by_|using_)?//r;
    no strict 'refs';
    $runs{$id} = sub { $sub->( $input ) };
}
cmpthese( -3, \%runs );

=cut

exit 0;