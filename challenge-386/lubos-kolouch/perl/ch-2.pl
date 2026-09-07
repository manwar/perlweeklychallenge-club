#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';
use Math::BigInt;

sub parse_rational ($str) {
    my $integer_part  = '0';
    my $non_repeating = '';
    my $repeating     = '';

    if ( $str =~ /^(\d+)(?:\.(\d*)(?:\((\d+)\))?)?$/ ) {
        $integer_part  = $1;
        $non_repeating = $2 // '';
        $repeating     = $3 // '';
    }
    else {
        die "Invalid rational string format: $str";
    }

    my $int_val = Math::BigInt->new($integer_part);
    my $num     = Math::BigInt->new(0);
    my $den     = Math::BigInt->new(1);

    if ( length($repeating) > 0 ) {
        my $k = length($repeating);
        my $m = length($non_repeating);

        my $rep_num     = Math::BigInt->new($repeating);
        my $non_rep_num = length($non_repeating) > 0 ? Math::BigInt->new($non_repeating) : Math::BigInt->new(0);

        my $nine9 = Math::BigInt->new( '9' x $k );
        my $ten_m = Math::BigInt->new(10)->bpow($m);

        # fraction = (non_rep * 99...9 + rep) / (99...9 * 10^m)
        $num = $non_rep_num * $nine9 + $rep_num;
        $den = $nine9 * $ten_m;
    }
    elsif ( length($non_repeating) > 0 ) {
        my $m = length($non_repeating);
        $num = Math::BigInt->new($non_repeating);
        $den = Math::BigInt->new(10)->bpow($m);
    }

    # Total = int_val + num/den = (int_val * den + num) / den
    my $total_num = $int_val * $den + $num;

    my $gcd = Math::BigInt::bgcd( $total_num, $den );
    $total_num->bdiv($gcd);
    $den->bdiv($gcd);

    return ( $total_num, $den );
}

sub compare_rationals ( $rat1, $rat2 ) {
    my ( $n1, $d1 ) = parse_rational($rat1);
    my ( $n2, $d2 ) = parse_rational($rat2);

    return ( $n1 == $n2 && $d1 == $d2 ) ? 1 : 0;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( compare_rationals( "0.(12)",    "0.(121)" ),   0, "Example 1" );
    is( compare_rationals( "0.1(23)",   "0.12(32)" ),  1, "Example 2" );
    is( compare_rationals( "0.1(234)",  "0.12(342)" ), 1, "Example 3" );
    is( compare_rationals( "12.99(99)", "13." ),       1, "Example 4" );
    is( compare_rationals( "0.(123)",   "0.1(231)" ),  1, "Example 5" );

    done_testing();
}
