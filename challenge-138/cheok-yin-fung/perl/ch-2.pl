#!/usr/bin/perl
# The Weekly Challenge 138
# Task 2 Split Number
# Usage: ch-2.pl $N
use v5.12.0;
use warnings;
use List::Util qw/ any sum /;
use Integer::Partition;
use Algorithm::Combinatorics qw / permutations /;
use Test::More tests => 6;

my $NUM = $ARGV[0] || 1;

say split_number($NUM);



sub split_number {
    my $N = $_[0];
    my $rt = sqrt $N;
    die "Input must be a square number\n" unless $rt == int $rt;
    my $len = length $N;
    my $upper = length $rt;

    my %wlen;       # hash to record each unordered partition
    return 0 if $N == 1;  #after reading Abigail's code
    my $i = Integer::Partition->new($len);
    while (my $len_a = $i->next) {
        next if any { $_ > $upper } @$len_a; 
        # Explanation for above line:
        # It is an optimization.
        # For example, sqrt(9663676416) = 98304
        # so we can expect partitions with $number > 99999,
        # i.e. length $number > 5, 
        # cannot fulfill the requirement.
        # (3rd public version, 2021-11-15 04:51 GMT)

        # NOT:::::: next if any { length $_ > $upper } @$len_a; 
        #     (2nd public version, 2021-11-15 04:35 GMT) 

        my $j = permutations($len_a);
        while (my $b = $j->next) {
            if (!defined($wlen{join ",", @$b})) {
                my @config = ( substr($N ,0, $b->[0]) );
                my $len_acc = 0;
                for my $k (0..scalar @$b - 2) {
                    $len_acc += $b->[$k];
                    my $temp = substr($N, $len_acc, $b->[$k+1]);
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
ok split_number(999*999) == 1, "test case 1 with 10^n-1";
ok split_number(9999*9999) == 1, "test case 2 with 10^n-1";
ok split_number(17073424) == 1, "final test";



=pod 
#for fun
 grep { 1 == split_number($_*$_)} 100..5000;

Output:
sqrt(81) = 9 = 8 + 1
sqrt(100) = 10 = 10 + 0
sqrt(1296) = 36 = 1 + 29 + 6
sqrt(2025) = 45 = 20 + 25
sqrt(3025) = 55 = 30 + 25
sqrt(6724) = 82 = 6 + 72 + 4
sqrt(8281) = 91 = 82 + 8 + 1
sqrt(9801) = 99 = 98 + 01
sqrt(10000) = 100 = 100 + 00
sqrt(55225) = 235 = 5 + 5 + 225
sqrt(88209) = 297 = 88 + 209
sqrt(136161) = 369 = 1 + 361 + 6 + 1
sqrt(136900) = 370 = 1 + 369 + (0)
sqrt(143641) = 379 = 14 + 364 + 1
sqrt(171396) = 414 = 17 + 1 + 396
sqrt(431649) = 657 = 4 + 3 + 1 + 649
sqrt(455625) = 675 = 45 + 5 + 625
sqrt(494209) = 703 = 494 + 209
sqrt(571536) = 756 = 5 + 715 + 36
sqrt(627264) = 792 = 62 + 726 + 4
sqrt(826281) = 909 = 826 + 2 + 81
sqrt(842724) = 918 = 842 + 72 + 4
sqrt(893025) = 945 = 8 + 930 + 2 + 5
sqrt(929296) = 964 = 929 + 29 + 6
sqrt(980100) = 990 = 980 + 10 + (0)
sqrt(982081) = 991 = 982 + 8 + 1
sqrt(998001) = 999 = 998 + 1
sqrt(1000000) = 1000 = 1000 + (0)
sqrt(1679616) = 1296 = 1 + 679 + 616
sqrt(2896804) = 1702 = 2 + 896 + 804
sqrt(3175524) = 1782 = 3 + 1755 + 24
sqrt(4941729) = 2223 = 494 + 1729
sqrt(7441984) = 2728 = 744 + 1984
sqrt(11329956) = 3366 = 11 + 3299 + 56
sqrt(13293316) = 3646 = 1 + 329 + 3316
sqrt(13557124) = 3682 = 1 + 3557 + 124
sqrt(17073424) = 4132 = 1 + 707 + 3424
sqrt(23804641) = 4879 = 238 + (0) + 4641
sqrt(24068836) = 4906 = 2 + 4068 + 836
sqrt(24502500) = 4950 = 2450 + 2500

