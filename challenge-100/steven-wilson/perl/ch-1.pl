#!/usr/bin/env perl
# You are given a time (12 hour / 24 hour).
# Write a script to convert the given time from 12 hour format to 24 hour 
# format and vice versa.
# Ideally we expect a one-liner.

use strict;
use warnings;
use Test::More;

my @input  = ( "05:15 pm", "19:15", "12:01", "12:00 am", "00:00", "12:01 pm", "05:15 am" );
my @output = ( "17:15", "07:15 pm", "12:01 pm", "00:00", "12:00 am", "12:01", "05:15" );
ok( convert_t_fmt( $input[0] ) eq $output[0], "test 1" );
ok( convert_t_fmt( $input[1] ) eq $output[1], "test 2" );
ok( convert_t_fmt( $input[2] ) eq $output[2], "test 3" );
ok( convert_t_fmt( $input[3] ) eq $output[3], "test 4" );
ok( convert_t_fmt( $input[4] ) eq $output[4], "test 5" );
ok( convert_t_fmt( $input[5] ) eq $output[5], "test 6" );
ok( convert_t_fmt( $input[6] ) eq $output[6], "test 7" );
done_testing();

sub convert_t_fmt {
    my $input = shift;
    my $output;
    $input =~ /(\d{1,2}):(\d{1,2})/;
    my $hour = $1;
    my $mins = $2;
    if ( $input =~ /pm/ ) {
        if ( $hour != 12 ) {
            $hour += 12;
        }
    }
    elsif ( $hour == 12 && ( $input =~ /am/ ) ) {
        $hour = 0;
    }
    elsif ( $hour > 12 ) {
        $hour -= 12;
        $mins .= " pm";
    }
    elsif ( $hour == 12 ) {
        $mins .= " pm";
    }
    elsif ( $hour == 0 ) {
        $hour = 12;
        $mins .= " am";
    }
    elsif ( $hour < 12 && !( $input =~ /am/ ) ) {
        $mins .= " am";
    }
    $output = sprintf "%02s:%02s", $hour, $mins;
}
