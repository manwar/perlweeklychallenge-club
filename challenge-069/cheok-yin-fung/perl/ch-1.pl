#!/usr/bin/perl
#
# Perl Weekly Challenge #069 Task 1 - Strobogrammatic Number
# Usage: ch-1.pl $A $B,  where 1 <= $A <= $B <= 10^15
# the following code goes "out of memory" around $B >= 10^11

use Algorithm::Combinatorics qw/variations_with_repetition/;
use strict;
use warnings;

sub rt180 {
    my @digits = split // , $_[0];
    my @newdigits = ();
    for (@digits) {
        my $nex;
        $nex = 1 if $_ == 1;
        $nex = 0 if $_ == 0;
        $nex = 8 if $_ == 8;
        $nex = 9 if $_ == 6;
        $nex = 6 if $_ == 9;
        unshift @newdigits, $nex;    
    }
    return join '', @newdigits;
}

my @ans = ();
my $begin = 3;
my $end = 4;
if ($ARGV[0] and $ARGV[1]) {
    $begin = $ARGV[0];
    $end = $ARGV[1]; 
}

my $sbegin = length $begin;
my $send = length $end;

if ($sbegin == 1) {
    $sbegin = 2;
    if ($send != 1) {
        @ans = ($begin..9);
    } else {
        @ans = ($begin..$end);
    }
}

for my $s ($sbegin .. $send) {
    foreach my $r (qw/1 6 8 9/) {
        my $o = variations_with_repetition([0, 1, 6, 8, 9],$s-1);
        while (my $y = $o->next) {
            my $string = $r.(join '', @{$y});
            push @ans, $string if $string eq rt180($string);
        }
    }
}


for (@ans) {
    print $_, " " if $_ <= $end and $_ >= $begin;
}


print "\n";


# $ time perl ch-1.pl 100000001 999999999 > ans069.txt (10^8+1 to 10^9-1)
# 
# real	0m9.288s
# user	0m9.282s
# sys	0m0.004s

# not very satisfactory
