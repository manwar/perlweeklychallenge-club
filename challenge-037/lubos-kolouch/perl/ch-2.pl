#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - London daylight gain/loss (Dec 2019 vs Nov 2019)

=head1 SYNOPSIS

  perl ch-2.pl        # runs embedded tests and prints total gain/loss

=head1 DESCRIPTION

Compute daylight gain/loss in December 2019 compared to November 2019 for
London, using official day-by-day sunrise/sunset data from timeanddate.com.

This challenge compares day 1..30 of December against day 1..30 of November.

=cut

sub daylight_gain_loss_minutes_dec_vs_nov_2019_london () {
    # Daylight(dec_day_i) - Daylight(nov_day_i), in minutes, for i=1..30.
    my @daily_diff = (
        -89, -87, -87, -84, -82, -80, -79, -78, -75, -72,
        -71, -68, -66, -63, -62, -60, -56, -54, -52, -49,
        -47, -45, -40, -38, -35, -33, -29, -28, -24, -21
    );

    my $sum = 0;
    $sum += $_ for @daily_diff;
    return $sum;
}

sub _format_minutes ($m) {
    my $sign = $m < 0 ? '-' : '+';
    my $x    = abs($m);
    my $h    = int( $x / 60 );
    my $min  = $x % 60;
    return sprintf( '%s%d:%02d', $sign, $h, $min );
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my $m = daylight_gain_loss_minutes_dec_vs_nov_2019_london();
    Test::More::is( $m, -1754, 'Total daylight difference in minutes' );
    Test::More::is( _format_minutes($m), '-29:14', 'Formatted as hours:minutes' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    die "Run without arguments.\n" if @args;
    _run_tests();

    my $m = daylight_gain_loss_minutes_dec_vs_nov_2019_london();
    say "December vs November 2019 daylight (London): " . _format_minutes($m) . " (hh:mm)";
    say "Total minutes: $m";
}

_run_cli(@ARGV);
