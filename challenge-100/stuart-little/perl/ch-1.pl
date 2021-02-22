#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <time in format hh:mm[am/pm]; 'am' or 'pm' can be capitalized or surrounded by spaces> 

use feature qw(signatures);
no warnings qw(experimental::signatures);
use List::MoreUtils qw(any);

sub convTime ($time) {
    $time =~ m/(\d+)\:(\d+)(.*)/;
    my ($h,$m) = ($1,$2);
    my $mode = $3;
    (index(lc $mode, "am") != -1) && return qq|${\ do {sprintf("%02d", $h % 12)}}:$m|;
    (index(lc $mode, "pm") != -1) && return qq|${\ do {sprintf("%02d", ($h % 12) + 12)}}:$m|;
    my $mer = (any {$_ == $h} (0..11)) ? (" am") : (" pm");
    my $modh = (any {$_ == $h} (1..12)) ? ($h) : (($h-12) % 24);  
    return qq|${\ do {sprintf("%02d", $modh)}}:$m$mer|;    
}

say convTime(join "", @ARGV);
