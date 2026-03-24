#!/usr/bin/env perl

# You are given a time in the form ‘HH:MM’. The earliest possible
# time is ‘00:00’ and the latest possible time is ‘23:59’. In the
# string time, the digits represented by the ‘?’ symbol are unknown,
# and must be replaced with a digit from 0 to 9.

# Write a script to return the count different ways we can
# make it a valid time.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

my $valid_time_re = qr{\b(?:[01]?\d|2[0-3]):[0-5]\d};

sub valid_times {
    my $time = shift;
    printf qq{ Input: $time = "%s"\n }, $time;

    my $result = 0;
    my %bnds = (
                 mo => { min => 0, max => 9 },
                 mt => { min => 0, max => 5 },
                 ho => { min => 0, max => 9 },
                 ht => { min => 0, max => 2 },
               );

    my $htv = substr( $time, 0, 1 );
    if ( $htv =~ m/\d/ ) {
        $bnds{ ht }->{ min } = $bnds{ ht }->{ max } = $htv;
    }
    my $hov = substr( $time, 1, 1 );
    if ( $hov =~ m/\d/ ) {
        $bnds{ ho }->{ min } = $bnds{ ho }->{ max } = $hov;
    }
    my $mtv = substr( $time, 3, 1 );
    if ( $mtv =~ m/\d/ ) {
        $bnds{ mt }->{ min } = $bnds{ mt }->{ max } = $mtv;
    }
    my $mov = substr( $time, 4, 1 );
    if ( $mov =~ m/\d/ ) {
        $bnds{ mo }->{ min } = $bnds{ mo }->{ max } = $mov;
    }

    for my $mo ( $bnds{ mo }->{ min } .. $bnds{ mo }->{ max } ) {
        for my $mt ( $bnds{ mt }->{ min } .. $bnds{ mt }->{ max } ) {
            for my $ho ( $bnds{ ho }->{ min } .. $bnds{ ho }->{ max } ) {
                for my $ht ( $bnds{ ht }->{ min } .. $bnds{ ht }->{ max } ) {
                    $result++ if ( qq{$ht$ho:$mt$mo} =~ $valid_time_re );
                }
            }
        }
    }

    printf qq{Output: %d\n}, $result;
    return $result;
}

my @examples = (
                 { in => "?2:34", out => 3,    name => 'example 1' },
                 { in => "?4:?0", out => 12,   name => 'example 2' },
                 { in => "??:??", out => 1440, name => 'example 3' },
                 { in => "?3:45", out => 3,    name => 'example 4' },
                 { in => "2?:15", out => 4,    name => 'example 5' },
               );

is( valid_times( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;
