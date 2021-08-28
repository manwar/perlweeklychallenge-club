#!/usr/bin/perl
# The Weekly Challenge 127
# Task 2 Conflict Intervals
# Usage: $ ch-2.pl 1 4 3 5 6 8 
# for checking intervals (1, 4), (3, 5), (6, 8)  
use warnings;
use v5.12.0;
use List::Util qw/max min/; 
use Test::More tests => 4;
use Test::Deep;

my @inp;

@inp = ([1,3], [3,4], [7,9]) if !defined($ARGV[0]);
if ((scalar @ARGV) % 2 == 1) {
    die "Even number of terms should be entered.\n";
}

for (my $i = 0; $i <= $#ARGV ;$i+=2) {
    die "Invalid interval: ($ARGV[$i], $ARGV[$i+1])\n" if $ARGV[$i] >= $ARGV[$i+1];
    push @inp, [$ARGV[$i], $ARGV[$i+1]];
}

my $answer = conflict_intervals(@inp);

if (scalar $answer->@* > 0) {
    say "($_->[0], $_->[1])" for $answer->@*;
}
else {
    say "No conflicts found."
}

sub conflict_intervals {
    my @intervals = @_;
    my @pre_intervals;
    my @new_intervals;
    my @ans;
    push @new_intervals, $intervals[0];

    for my $i (1..$#intervals) {
        my $bool_cf = undef;
        @pre_intervals = @new_intervals;
        @new_intervals = ();
        for my $interv (@pre_intervals) {
            if (conf( $intervals[$i], $interv)) {
                push @new_intervals, merge($intervals[$i], $interv);
                $bool_cf = 1;
            }
            else {
                push @new_intervals, $interv;
            }
        }
        push @new_intervals, $intervals[$i] if !$bool_cf;
        push @ans, $intervals[$i] if $bool_cf;
    }
    return [@ans];
}

sub merge {
    return [ 
      min($_[0]->[0], $_[1]->[0]), 
      max($_[0]->[1], $_[1]->[1])
    ];
}

sub conf {
    my $i1;
    my $i2;
    if ($_[0]->[0] < $_[1]->[0]) {
        $i1 = $_[0];
        $i2 = $_[1];
    }
    elsif ($_[0]->[0] > $_[1]->[0]) {
        $i1 = $_[1];
        $i2 = $_[0];
    }
    else {
        return 1;
    }
    return 1 if $i1->[1] > $i2->[0];
    return 0;
}

cmp_deeply( 
    conflict_intervals([1,4], [3,5], [6,8], [12, 13], [3, 20]), 
    [[3,5],[3,20]] , 
    "Example 1" 
);
cmp_deeply( 
    conflict_intervals([3,4], [5,7], [6,9], [10,12], [13, 15]),
    [[6,9]],
    "Example 2"
);
cmp_deeply(
    conflict_intervals(
        [0, 2], [11, 15], [12, 19], [16, 23], [17, 18], 
        [15, 17], [19, 25], [7, 9], [1, 3], [3, 8]
    ),
    [ [12,19], [16,23], [17,18], [15,17], [19, 25], [1, 3], [3, 8]],
    "Test 1"
);
cmp_deeply(
    conflict_intervals(
        [14, 28], [9, 13], [6, 16], [12, 15], [28, 36],
        [6, 24], [15, 22], [13, 16], [1, 16], [8, 27]
    ),
    [[6,16], [12, 15], [6, 24], [15, 22], [13, 16], [1, 16], [8, 27]],
    "Test 2"
);
