#!/usr/bin/env perl6

# ch-1.p6 - Light tracker, with grammars because why not
#
# Ryan Thompson <rjt@cpan.org>

#| Grammar for one of the data-lines()
grammar TimeData {
    rule  TOP   { <num> ")" <who> "IN:" <time> "OUT:" <time> }
    token num   { \d+   }
    token who   { \w+   }
    token hh    { 0\d | 1 <[012]> }
    token mm    { <[0..5]> \d     }
    token time  { <hh> ":" <mm>   }
}

sub MAIN() {
    my %on is SetHash; # Minutes when the light was on

    for (DATA().lines) {
        my $parse = TimeData.parse($_) or next;
        my ($in, $out) = $parse<time>.list;

        %on{ minutes($in) .. minutes($out) }»++;
    }

    say %on.elems;
}

#| Convert $time<hh mm> hash to minutes since midnight
sub minutes( TimeData $time ) { $time<hh> * 60 + $time<mm> }

#| Input data
sub DATA() {
    q:to/END_RAW/,
        0) Ryan    IN: 03:25 OUT: 04:20
        1) Alex    IN: 09:10 OUT: 09:45
        2) Arnold  IN: 09:15 OUT: 09:33
        3) Bob     IN: 09:22 OUT: 09:55
        4) Charlie IN: 09:25 OUT: 10:05
        5) Steve   IN: 09:33 OUT: 10:01
        6) Roger   IN: 09:44 OUT: 10:12
        7) David   IN: 09:57 OUT: 10:23
        8) Neil    IN: 10:01 OUT: 10:19
        9) Chris   IN: 10:10 OUT: 11:00
        END_RAW
}
