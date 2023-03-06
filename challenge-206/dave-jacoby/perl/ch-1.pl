#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use DateTime;

my @examples = (

    [ "00:00", "23:55", "20:00" ],
    [ "01:01", "00:50", "00:57" ],
    [ "10:10", "09:30", "09:00", "09:55" ],
    [ "03:00", "06:01", "09:02" ],
);

for my $e (@examples) {
    my $list = join ',', map { qq{"$_"} } $e->@*;
    my $out  = shortest_time( $e->@* );
    say <<"END";
    Input:  \@array = ($list)
    Output: $out
END
}

sub shortest_time ( @array ) {
    my @output;
    my $day_length      = 86400;             # give or take leap seconds, etc
    my $half_day_length = $day_length / 2;
    return 0 unless scalar @array > 1;
    my @times = map { make_time($_) } @array;
    for my $i ( 0 .. -2 + scalar @array ) {
        my $t1 = $times[$i];
        for my $j ( $i + 1 .. -1 + scalar @array ) {
            my $t2   = $times[$j];
            my $diff = $t1->subtract_datetime_absolute($t2)->seconds;
            if ( $diff > $half_day_length ) { $diff = $day_length - $diff; }
            push @output, $diff / 60;        # cast as int?
        }
    }
    return ( sort { $a <=> $b } @output )[0];
}

sub make_time ( $string ) {
    my ( $hr, $min ) = split /:/, $string;
    return DateTime->now->set_hour($hr)->set_minute($min)->set_second(0)
        ->set_time_zone('floating');
}
