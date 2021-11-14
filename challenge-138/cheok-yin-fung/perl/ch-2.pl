#!/usr/bin/perl
# The Weekly Challenge 138
# Task 2 Split Number
# Usage: ch-2.pl $N
use v5.12.0;
use warnings;
use List::Util qw/ any sum /;
use Integer::Partition;
use Algorithm::Combinatorics qw / permutations /;
use Test::More tests => 3;

my $NUM = $ARGV[0] || 1;

say split_number($NUM);



sub split_number {
    my $N = $_[0];
    my $rt = sqrt $N;
    die "Input must be a square number\n" unless $rt == int $rt;
    my $len = length $N;
    my $upper = length $rt;

    my %wlen;       # hash to record each unordered partition

    my $i = Integer::Partition->new($len);
    while (my $a = $i->next) {
        next if any { $_ > $upper } @$a; 
        # Explanation for above line:
        # It is an optimization.
        # For example, sqrt(9663676416) = 98304
        # so we can expect partitions with number > 99999,
        # i.e. length number > 5, 
        # cannot fulfill the requirement.
        my $j = permutations($a);
        while (my $b = $j->next) {
            if (!defined($wlen{join ",", @$b})) {
                my @config = ( substr($N ,0, $b->[0]) );
                my $acc = 0;
                for my $k (0..scalar @$b - 2) {
                    $acc += $b->[$k];
                    my $temp = substr($N, $acc, $b->[$k+1]);
                    $temp =~ s/^[0]*//g;
                    $temp = 0 if $temp eq "";
                    push @config, $temp;
                }
                if ( (sum @config) == $rt) {
                    say "sqrt($N) = " ,     #print the formula
                        "$rt = ", 
                        join " + ", map { $_ == 0 ? "(0)" : $_ } @config;
                    return 1;
                }
                $wlen{join ",", @$b} = 1;
            }
        }
    }

    return 0;
}

ok split_number(81) == 1, "Example 1";
ok split_number(9801) == 1, "Example 2";
ok split_number(36) == 0, "Example 3";


=pod for fun
for my $num (1..100) {
    split_number($num*$num);
}

Output:
sqrt(1) = 1 = 1
sqrt(81) = 9 = 8 + 1
sqrt(100) = 10 = 10 + 0
sqrt(1296) = 36 = 1 + 29 + 6
sqrt(2025) = 45 = 20 + 25
sqrt(3025) = 55 = 30 + 25
sqrt(6724) = 82 = 6 + 72 + 4
sqrt(8281) = 91 = 82 + 8 + 1
sqrt(9801) = 99 = 98 + 01
sqrt(10000) = 100 = 100 + 00

