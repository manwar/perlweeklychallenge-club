#!/usr/bin/env perl6
use v6;

# run <script> <time in format hh:mm[am/pm]; 'am' or 'pm' can be capitalized or surrounded by spaces> 

sub convTime ($time) {
    $time ~~ m/(\d+)\:(\d+)(.*)/;
    my ($h,$m) = ($0,$1).map(*.Int);
    my $mode = $2;
    $mode.Str.lc.contains("am") && return qq|{sprintf("%02d", $h % 12)}:$1|;
    $mode.Str.lc.contains("pm") && return qq|{sprintf("%02d", ($h % 12) + 12)}:$1|;
    my $mer = ([0..11].grep($h)) ?? (" am") !! (" pm");
    my $modh = ([1..12].grep($h)) ?? ($h) !! (($h-12) % 24);  
    return qq|{sprintf("%02d", $modh)}:$1$mer|;    
}

say convTime(@*ARGS.join);
