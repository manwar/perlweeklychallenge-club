#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Bus Route

=head1 SYNOPSIS

  perl ch-2.pl 12 11 41  15 5 35
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Each route is described by [interval, offset, duration]. For each minute t
within the hour (0..59), determine whether taking the earliest departing bus
at or after t is worse than waiting for a strictly later departure that
arrives strictly earlier.

Returns a list of such minutes.

=cut

my $ROUTES_CHECK = compile( ArrayRef [ArrayRef [Int]] );

sub _next_departure ($t, $interval, $offset) {
    return $offset if $t <= $offset;
    my $k = int( ( $t - $offset + $interval - 1 ) / $interval );
    return $offset + $k * $interval;
}

sub bus_route ($routes) {
    ($routes) = $ROUTES_CHECK->($routes);
    die 'Expected at least one route' if @$routes == 0;

    my @bad;
    for my $t ( 0 .. 59 ) {
        my $dmin           = undef;
        my $best_arrival   = undef;
        my $best_departure = undef;
        my $best_at_dmin   = undef;

        for my $r (@$routes) {
            my ( $interval, $offset, $duration ) = @$r;
            my $dep = _next_departure( $t, $interval, $offset );
            my $arr = $dep + $duration;

            if ( !defined($dmin) || $dep < $dmin ) {
                $dmin         = $dep;
                $best_at_dmin = $arr;
            }
            elsif ( $dep == $dmin ) {
                $best_at_dmin = $arr if $arr < $best_at_dmin;
            }

            if ( !defined($best_arrival) || $arr < $best_arrival ) {
                $best_arrival   = $arr;
                $best_departure = $dep;
            }
        }

        if ( defined($best_departure)
            && defined($dmin)
            && $best_departure > $dmin
            && $best_arrival < $best_at_dmin )
        {
            push @bad, $t;
        }
    }

    return \@bad;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <interval offset duration>...\n" if @args % 3 != 0;
    my @routes;
    while (@args) {
        my ( $i, $o, $d ) = splice @args, 0, 3;
        push @routes, [ 0 + $i, 0 + $o, 0 + $d ];
    }
    my $out = bus_route( \@routes );
    say "Output: [ " . join( ', ', @$out ) . " ]";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label  => 'Example 1',
            routes => [ [ 12, 11, 41 ], [ 15, 5, 35 ] ],
            expected => [ 36 .. 47 ],
        },
        {
            label  => 'Example 2',
            routes => [ [ 12, 3, 41 ], [ 15, 9, 35 ], [ 30, 5, 25 ] ],
            expected => [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59 ],
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is_deeply( bus_route( $case->{routes} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 bus_route($routes)

Returns an arrayref of minutes when waiting for a later bus is better.

=cut

