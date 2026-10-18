#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Math::BigInt;

=pod

=head1 NAME

ch-2.pl - Poker Hand Rankings (WWC 291 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl   # runs calculations and embedded tests

=head1 DESCRIPTION

A draw poker hand consists of 5 cards drawn from a standard pack of 52 cards.
An ace can rank either high or low.

This script determines:
1. Total number of 5-card hands: C(52, 5).
2. Number of different hands for each of the 10 ranks.
3. Verification that the sum of the 10 rank counts equals total hands.

=cut

sub nCr ( $n, $r ) {
    return Math::BigInt->new(0) if $r < 0 || $r > $n;
    return Math::BigInt->new(1) if $r == 0 || $r == $n;
    $r = $n - $r if $r > $n - $r;

    my $num = Math::BigInt->new(1);
    my $den = Math::BigInt->new(1);

    for my $i ( 1 .. $r ) {
        $num->bmul( $n - $i + 1 );
        $den->bmul($i);
    }
    return $num->bdiv($den);
}

sub calculate_poker_hands () {
    my $total_hands = nCr( 52, 5 );
    my %counts;

    # 1. Royal Flush: 4 suits * 1
    $counts{'Royal Flush'} = Math::BigInt->new(4);

    # 2. Straight Flush: 9 possible rank starts (A-2-3-4-5 up to 9-10-J-Q-K) * 4 suits
    $counts{'Straight Flush'} = Math::BigInt->new( 9 * 4 );

    # 3. Four of a Kind: 13 ranks * C(4,4) * 48 remaining cards
    $counts{'Four of a Kind'} = Math::BigInt->new(13)->bmul( nCr( 48, 1 ) );

    # 4. Full House: 13 * C(4,3) * 12 * C(4,2)
    $counts{'Full House'} = Math::BigInt->new(13)->bmul( nCr( 4, 3 ) )->bmul(12)->bmul( nCr( 4, 2 ) );

    # 5. Flush: 4 suits * C(13,5) - Royal Flush - Straight Flush
    my $all_flushes = Math::BigInt->new(4)->bmul( nCr( 13, 5 ) );
    $counts{'Flush'} = $all_flushes->bsub( $counts{'Royal Flush'} )->bsub( $counts{'Straight Flush'} );

    # 6. Straight: 10 sequences * 4^5 - Royal Flush - Straight Flush
    my $all_straights = Math::BigInt->new(10)->bmul( Math::BigInt->new(4)->bpow(5) );
    $counts{'Straight'} = $all_straights->bsub( $counts{'Royal Flush'} )->bsub( $counts{'Straight Flush'} );

    # 7. Three of a Kind: 13 * C(4,3) * C(12,2) * 4^2
    $counts{'Three of a Kind'} =
      Math::BigInt->new(13)->bmul( nCr( 4, 3 ) )->bmul( nCr( 12, 2 ) )->bmul( Math::BigInt->new(4)->bpow(2) );

    # 8. Two Pair: C(13,2) * C(4,2)^2 * 11 * 4
    $counts{'Two Pair'} =
      nCr( 13, 2 )->bmul( nCr( 4, 2 )->bpow(2) )->bmul(11)->bmul(4);

    # 9. One Pair: 13 * C(4,2) * C(12,3) * 4^3
    $counts{'One Pair'} =
      Math::BigInt->new(13)->bmul( nCr( 4, 2 ) )->bmul( nCr( 12, 3 ) )->bmul( Math::BigInt->new(4)->bpow(3) );

    # 10. High Card: Total hands - all other hands
    my $sum_non_high = Math::BigInt->new(0);
    for my $rank ( keys %counts ) {
        $sum_non_high->badd( $counts{$rank} );
    }
    $counts{'High Card'} = Math::BigInt->new($total_hands)->bsub($sum_non_high);

    return ( $total_hands, \%counts );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my ( $total, $counts ) = calculate_poker_hands();
    say "Total 5-card hands: $total";
    for my $rank (
        'Royal Flush', 'Straight Flush', 'Four of a Kind', 'Full House',
        'Flush',       'Straight',       'Three of a Kind', 'Two Pair',
        'One Pair',    'High Card'
      )
    {
        printf "%-16s: %s\n", $rank, $counts->{$rank};
    }
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my ( $total, $counts ) = calculate_poker_hands();

    # Known combinatorial hand counts
    my %expected = (
        'Royal Flush'     => 4,
        'Straight Flush'  => 36,
        'Four of a Kind'  => 624,
        'Full House'      => 3744,
        'Flush'           => 5108,
        'Straight'        => 10200,
        'Three of a Kind' => 54912,
        'Two Pair'        => 123552,
        'One Pair'        => 1098240,
        'High Card'       => 1302540,
    );

    Test::More::plan( tests => 12 );
    Test::More::is( $total->bstr, '2598960', 'Total hands is 2,598,960' );

    my $sum = Math::BigInt->new(0);
    for my $rank (
        'Royal Flush', 'Straight Flush', 'Four of a Kind', 'Full House',
        'Flush',       'Straight',       'Three of a Kind', 'Two Pair',
        'One Pair',    'High Card'
      )
    {
        Test::More::is( $counts->{$rank}->bstr, "$expected{$rank}", "$rank count matches" );
        $sum->badd( $counts->{$rank} );
    }

    Test::More::is( $sum->bstr, $total->bstr, 'Sum of all 10 ranks equals total hands' );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 nCr($n, $r)

Calculates the binomial coefficient C(n, r) using Math::BigInt.

=head2 calculate_poker_hands()

Calculates total 5-card combinations and frequencies of all 10 poker hand ranks.

=cut
