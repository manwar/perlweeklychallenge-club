#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 100, TASK #1 › Fun Time
#
# You are given a time (12 hour / 24 hour).
# Write a script to convert the given time from 12 hour format to 24 hour format and vice versa.
# Ideally we expect a one-liner.
# Example 1: Input: 05:15 pm or 05:15pm Output: 17:15
# Example 2: Input: 19:15 Output: 07:15 pm or 07:15pm
# 
#=============================================================================

use strict;
use warnings;
use 5.020;
use experimental qw/signatures/;

use Getopt::Long;

my $DoTest = 0;
GetOptions('test' => \$DoTest);

runTest() if $DoTest;

for my $tstr ( @ARGV )
{
    say funTime($tstr);
}

sub funTime($t)
{
    my ($hr,$min) = $t =~ m/(\d{1,2}):(\d\d)/;
    return "--:--" if ( $hr < 0 || $hr > 24 || $min < 0 || $min > 59 );
    my $suf;

    if    ( $t =~ m/am/i ) { $suf = ""  ;                        }
    elsif ( $t =~ m/pm/i ) { $suf = ""  ; $hr += 12 if $hr < 12; }
    elsif ( $hr == 24 )    { $suf = "am"; $hr = 0;               }
    elsif ( $hr == 12 )    { $suf = "pm";                        }
    elsif ( $hr <  12 )    { $suf = "am";                        }
    else                   { $suf = "pm"; $hr -= 12;             }

    return sprintf "%02d:%02d%s", $hr, $min, $suf;
}

sub runTest
{
    use Test::More;
    for my $case (
                    ['05:15', '05:15am'],
                    ['19:15', '07:15pm'],
                    ['00:00', '00:00am'],
                    ['11:15', '11:15am'],
                    ['23:45', '11:45pm'],
                    ['12:00', '12:00pm'],
                 )
    {
        is( funTime($case->[0]), $case->[1] );
        is( funTime($case->[1]), $case->[0] );
    }
    is( funTime("24:00"), "00:00am");

    done_testing;
}
