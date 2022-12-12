#!/usr/bin/perl
use 5.030;
use warnings;
use experimental 'switch';



my $time = shift or die "Need time in the format hh:mm with one missing digit replaced by '?'\n";

given (index $time, '?') {
    when (0) { 
        given (substr($time, 1, 1)) {
            when ([0 .. 3]) { say 2; }
            default { say 1; }
        }
    }
    when (1) {
        given (substr($time, 0, 1)) {
            when ([0 .. 1]) { say 9; }
            when (2) { say 3; }
            default { die "Illegal time\n"; }
        }
    }
    when (3) { say 5; }
    when (4) { say 9; }
    default { die "No ? or ? is in an illegal position.\n"; }
}