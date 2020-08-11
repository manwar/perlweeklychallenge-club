#!/usr/bin/perl

use strict;
use Data::Dumper;
use List::Util qw/sum/;

#  $steps : a string looks like DDDDRRRR,  DDRRRR, RDRDRD... 

# my @ms = ([1,2,3], [4,5,6], [7,8,9]); # ms = shorthand of  matrixrows 
# ans = 21
# my @ms = ([1, 4, 7], [2, 0, 8], [3, 6, 9]); 
# ans = 21
 my @ms = ([1, 4, 7, 12], [2, 0, 8, 9], [3, 6, 9, 8]); 
# ans = 26

my @min_path;

my $M = $#ms+1;
my $N = $#{$ms[0]} + 1;
my $totsteps = $M+$N-2;

# a starting minimum
my $refmin = sum @{$ms[0]};
for (1..$M-1) {
    $refmin += ${$ms[$_]}[$N-1];
}

sub go {
    my $steps = $_[0];
    my $hardship = $_[1];
    $hardship += ${$ms[otimes($steps, 'D')]}[otimes($steps,'R')];
    myseek($steps, $hardship) if ($hardship <= $refmin);
}



sub myseek {
    my $steps = $_[0];
    my $hardship = $_[1];
    #    print $steps, " ", $hardship, "\n";    for testing
    if ( (length $steps) < $totsteps ) {
        go($steps.'D', $hardship) if $M-1 > otimes($steps, 'D');
        go($steps.'R', $hardship) if $N-1 > otimes($steps, 'R');
    } 
    elsif ( $hardship <= $refmin) {
        @min_path = tour($steps);
        $refmin = $hardship;
    }
}


sub otimes {
    my $t = 0;
    for my $x (split //, $_[0]) {
        if ($x eq $_[1]) {
            $t++;
        }
    }
    return $t;
}

sub tour {
    my $steps = $_[0];
    my @_a = ( ${ms[0]}[0] );
    my $x = 0;
    my $y = 0;
    my @ways = split //, $steps;
    for my $w (@ways) {
        if ($w eq 'D') {$y++;}
        if ($w eq 'R') {$x++;}
        push @_a, ${ms[$y]}[$x];
    }
#    push @_a, ${ms[$M-1]}[$N-1];
    return @_a;
}


myseek('',${$ms[0]}[0]);

print $refmin, "\n";
print join " -> ", @min_path;
print "\n";
