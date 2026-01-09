#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Time::Piece;
use Time::Seconds;
use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-2.pl - Business Date

=head1 SYNOPSIS

  perl ch-2.pl "2022-08-01 10:30" 4
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a timestamp (date with time) and a duration in hours, return the time
that occurs duration business hours after the timestamp. Business hours are
09:00-18:00, Monday-Friday.

=cut

my $ARGS_CHECK = compile( Str, Str );

sub _is_weekend ($tp) {
    my $wday = $tp->_wday;    # 1=Mon .. 7=Sun
    return $wday >= 6 ? 1 : 0;
}

sub _next_business_start ($tp) {
    while ( _is_weekend($tp) ) {
        $tp += ONE_DAY;
        $tp = Time::Piece->strptime( $tp->ymd . ' 09:00', '%Y-%m-%d %H:%M' );
    }
    my $day = $tp->ymd;
    my $start = Time::Piece->strptime( "$day 09:00", '%Y-%m-%d %H:%M' );
    my $end   = Time::Piece->strptime( "$day 18:00", '%Y-%m-%d %H:%M' );

    if ( $tp < $start ) {
        return $start;
    }
    if ( $tp >= $end ) {
        my $next = $tp + ONE_DAY;
        $next = Time::Piece->strptime( $next->ymd . ' 09:00', '%Y-%m-%d %H:%M' );
        return _next_business_start($next);
    }
    return $tp;
}

sub _duration_to_minutes ($duration) {
    if ( $duration =~ /\A(\d+)(?:\.(\d+))?\z/ ) {
        my ( $i, $f ) = ( 0 + $1, $2 );
        my $minutes = $i * 60;
        if ( defined $f ) {
            my $den = 10**length($f);
            $minutes += int( ( ( 0 + $f ) * 60 + $den / 2 ) / $den );
        }
        return $minutes;
    }
    die "Invalid duration: $duration";
}

sub business_date ($timestamp, $duration) {
    ( $timestamp, $duration ) = $ARGS_CHECK->( $timestamp, $duration );

    my $tp = Time::Piece->strptime( $timestamp, '%Y-%m-%d %H:%M' );
    my $remaining = _duration_to_minutes($duration);

    $tp = _next_business_start($tp);

    while ( $remaining > 0 ) {
        $tp = _next_business_start($tp);
        my $day = $tp->ymd;
        my $end = Time::Piece->strptime( "$day 18:00", '%Y-%m-%d %H:%M' );

        my $available = int( ( $end - $tp ) / ONE_MINUTE );
        my $take = $remaining < $available ? $remaining : $available;
        $tp += $take * ONE_MINUTE;
        $remaining -= $take;

        if ( $remaining > 0 ) {
            my $next = Time::Piece->strptime( ( $tp + ONE_DAY )->ymd . ' 09:00', '%Y-%m-%d %H:%M' );
            $tp = _next_business_start($next);
        }
    }

    return $tp->strftime('%Y-%m-%d %H:%M');
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 \"YYYY-MM-DD HH:MM\" <duration-hours>\n" if @args != 2;
    my ( $ts, $dur ) = @args;
    my $out = business_date( $ts, $dur );
    say $out;
}

sub _run_tests {
    require Test::More;
    Test::More->import;
    Test::More::plan( tests => 2 );
    Test::More::is( business_date( '2022-08-01 10:30', '4' ),   '2022-08-01 14:30', 'Example 1' );
    Test::More::is( business_date( '2022-08-01 17:00', '3.5' ), '2022-08-02 11:30', 'Example 2' );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 business_date($timestamp, $duration)

Returns the timestamp that is C<$duration> business-hours after C<$timestamp>.

=cut

