#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-12-16
# Week: 039

# TASK #1
# A guest house had a policy that the light remain ON as long as the at
# least one guest is in the house. There is guest book which tracks all
# guest in/out time. Write a script to find out how long in minutes the
# light were ON.
# Guest Book
# 1) Alex    IN: 09:10 OUT: 09:45
# 2) Arnold  IN: 09:15 OUT: 09:33
# 3) Bob     IN: 09:22 OUT: 09:55
# 4) Charlie IN: 09:25 OUT: 10:05
# 5) Steve   IN: 09:33 OUT: 10:01
# 6) Roger   IN: 09:44 OUT: 10:12
# 7) David   IN: 09:57 OUT: 10:23
# 8) Neil    IN: 10:01 OUT: 10:19
# 9) Chris   IN: 10:10 OUT: 11:00

# Answer: Lights were on for 111 minutes

use strict;
use warnings;
use feature qw/ say /;

my %guestbook = (
    "Alex"    => [ "09:10", "09:45" ],
    "Arnold"  => [ "09:15", "09:33" ],
    "Bob"     => [ "09:22", "09:55" ],
    "Charlie" => [ "09:25", "10:05" ],
    "Steve"   => [ "09:33", "10:01" ],
    "Roger"   => [ "09:44", "10:12" ],
    "David"   => [ "09:57", "10:23" ],
    "Neil"    => [ "10:01", "10:19" ],
    "Chris"   => [ "10:10", "11:00" ],
);
my %light;

for my $guest ( keys %guestbook ) {
    my ( $s_hour, $s_minute ) = split ":", $guestbook{$guest}[0];
    my ( $f_hour, $f_minute ) = split ":", $guestbook{$guest}[1];
    while (
        sprintf( "%.2d:%.2d", $s_hour, $s_minute ) ne
        sprintf( "%.2d:%.2d", $f_hour, $f_minute ) )
    {
        $light{sprintf( "%.2d:%.2d", $s_hour, $s_minute )} = 1;
        if ( $s_minute == 59 ) {
            $s_minute = 0;
            $s_hour++;
        }
        else {
            $s_minute++;
        }
    }
    $light{sprintf( "%.2d:%.2d", $f_hour, $f_minute )} = 1;
}

say "Lights were on for ", scalar keys %light, " minutes";
