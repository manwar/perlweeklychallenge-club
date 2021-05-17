#!/usr/bin/perl
# The Weekly Challenge 112
# Task 2 Climb Stairs
use strict;
use warnings;
use Algorithm::Combinatorics qw /combinations/;

my $n = $ARGV[0] || 5;

if ($n <= 1) {
    print "For one step to climb, there is only one option: \n1\n";
} else {

# ================== BEGIN: MAIN BODY OF THE SCRIPT =========
my @all;

for my $i ($n%2+$n/2 .. $n-1) {
    my $iter = combinations([0..$i-1] , ($n-$i) );
    my $str = "1" x $i;
    while (my $c = $iter->next) {
        my $str_clone = $str;
        substr($str_clone, $_, 1) = "2" for (@{$c});
        push @all, $str_clone;
    }
}

push @all , "1" x $n;
print "For $n steps to climb, the number of options is ", scalar @all, ":\n";
print join "\n", @all;
print "\n";

# ==================== END: MAIN BODY OF THE SCRIPT =========

}
