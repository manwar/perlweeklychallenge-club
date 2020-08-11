#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-039/
# Task #1
# A guest house had a policy that the light remain ON as long as the at least one guest is in the house.
# There is guest book which tracks all guest in/out time.
# Write a script to find out how long in minutes the light were ON.
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

use strict;
use warnings;

die "No guestbook selected." unless @ARGV;

my @gb = ();
my $guests = 0;

# We process the file line by line, and create a cleaned up hash with time and action
while(<>){
    chomp;
    my ( $i, $guest, $in, $in_time, $out, $out_time ) = split;
    my %record = ();

    push @gb, {
        time => time_to_minutes($in_time),
        action => substr($in,0,-1)
    };

    push @gb, {
        time => time_to_minutes($out_time),
        action => substr($out,0,-1)
    };

}

my $timer_start = 0;
my $timer = 0;

for ( sort { $a->{time} <=> $b->{time} } @gb ){

    if ($_->{action} eq 'IN'){
        $guests++;
        # We need to check if there was someone before
        # If so we don't care about that action
        $timer_start = $_->{time} if $guests == 1;
    }else{
        $guests--;
        # When the last person checks out, we sum up the time
        $timer += $_->{time} - $timer_start if $guests == 0;
    }

}
print "The lights where on for $timer minutes\n";

sub time_to_minutes {
    my $time = shift;
    my ($h, $m) = split /:/, $time;
    return $h * 60 + $m;
}
