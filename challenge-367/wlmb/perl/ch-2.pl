#!/usr/bin/env perl
# Perl weekly challenge 367
# Task 2:  Conflict Events
#
# See https://wlmb.github.io/2026/03/30/PWC367/#task-2-conflict-events
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 E0 E1...
    to find if the events En are conflicting, where
    En is a space separated string of four times
    "T0 T1 T2 T3", each of the form HH:MM. T0 and T1 are
    starting and ending times for one event, T2 and T3 correspond
    to the second event
    FIN
my $day=24*60;
for(@ARGV){
    try {
        die "Wrong format: $_" unless /^\s*((\d\d):(\d\d)(\s|$)){4}$/;
        my @minutes = map {my ($hour,$min) = split":"; 60*$hour + $min} split" ";
        do{$minutes[$_+1] +=$day if $minutes[$_] > $minutes[$_+1]} for(0,2);
        my $result = overlap(0, @minutes)
            || overlap($day, @minutes)
            || overlap(-$day,@minutes);
        say "$_ -> ", $result?"True":"False";
    }
    catch($e){warn $e; }
}

sub overlap($offset, $w, $x, $y, $z){
    $w + $offset < $z && $x + $offset >$y
}
