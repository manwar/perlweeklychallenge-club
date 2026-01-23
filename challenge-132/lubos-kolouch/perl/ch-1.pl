#!/usr/bin/perl
use strict;
use warnings;
use DateTime;
use DateTime::Format::ISO8601;

sub get_mirror_dates {
    my ( $input, $today ) = @_;

    my $strp     = DateTime::Format::Strptime->new( pattern => '%Y/%m/%d', );
    my $dt_input = $strp->parse_datetime($input);

    my $dt_now = DateTime->now;

    $dt_now = $strp->parse_datetime($today) unless $today eq 'now';

    # Use day-based delta to avoid month-length/leap-year issues when applying
    # a calendar duration back and forth.
    my $days = $dt_now->delta_days($dt_input)->in_units('days');

    my $dt_mirror_prev = $dt_input->clone->subtract( days => $days );
    my $dt_mirror_next = $dt_now->clone->add( days => $days );

    return $dt_mirror_prev->strftime('%Y/%m/%d') . ', ' . $dt_mirror_next->strftime('%Y/%m/%d');
}

use Test::More;

is( get_mirror_dates( '2021/09/18', '2021/09/22' ), '2021/09/14, 2021/09/26' );
is( get_mirror_dates( '1975/10/10', '2021/09/22' ), '1929/10/27, 2067/09/05' );
is( get_mirror_dates( '1967/02/14', '2021/09/22' ), '1912/07/08, 2076/04/30' );

done_testing;
