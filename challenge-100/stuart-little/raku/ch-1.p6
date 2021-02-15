#!/usr/bin/env perl6
use v6;

# run <script> <time in format hh:mm[am/pm]; 'am' or 'pm' can be capitalized or surrounded by spaces> 

sub convTime ($time) {
    $time ~~ m/(\d+)\:(\d+)(.*)/;
    (! $2.Str) && ($0.Int == 0) && return qq|{$0+12}:$1| ~ " am";
    (! $2.Str) && ($0.Int < 12) && return $time ~ " am";
    (! $2.Str) && ($0.Int == 12) && return $time ~ " pm";
    (! $2.Str) && ($0.Int > 12) && return qq|{sprintf("%02d", $0-12)}:$1| ~ " pm";
    $2.Str.lc.contains("am") && return qq|$0:$1|;
    $2.Str.lc.contains("pm") && return qq|{$0+12}:$1|;    
}

say convTime(@*ARGS.join);
