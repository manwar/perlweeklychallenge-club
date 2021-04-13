#!/usr/bin/perl
# The Weekly Challenge 108
# Task 2 Bell Numbers
# ---
# Usage: $ ch-1.pl N
#        first N Bell numbers with the 0th case

use strict;
use warnings;
use Integer::Partition;
# use Test::Simple tests => 8;

# n_C_r
sub combin {
    my ($n, $r) = ($_[0], $_[1]);
    my $a = 1;
    $a *= $_ for ($n-$r+1..$n);
    $a /= $_ for (1..$r);
    return $a;
}

sub factorial {
    my $ans = 1;
    $ans *= $_ for (1..$_[0]);
    return $ans;
}

sub bell_num {
    my $m = $_[0];
    my $ans = 0;
    return 1 if $m == 0 or $m == 1;
    my $i = Integer::Partition->new($m);
    while (my $partition = $i->next) {
        my @list = @$partition;
        $ans += process_combin($m, $partition)/dup($partition);
    }
    return $ans;
}

sub process_combin {
    my $var_m = $_[0];
    my @arr = @{$_[1]};
    @arr = grep {$_ != 1} @arr;  # save a bit of time
    my $ans = 1;
    for (0..$#arr) {
        $ans *= combin($var_m, $arr[$_]);
        $var_m = $var_m - $arr[$_];
    }
    return $ans;
}

sub dup {
    my @arr = @{$_[0]};
    @arr = grep {$_ != 1} @arr;  # save a bit of time
    my $ans = 1;

    my $preced = $arr[0];
    my $dup_term = 1;
    for (1..$#arr) {
        if ($preced != $arr[$_]) {
            $ans *= factorial($dup_term) if $dup_term != 1;
                             # the if clause, saves a of bit time
            $preced = $arr[$_];
            $dup_term = 1;
        }
        else {
            $dup_term++;
        }
    }
    if ($dup_term != 1) {
        $ans *= factorial($dup_term);
    }
    return $ans;
}


my $N = $ARGV[0] || 10;

for (0..$N) {
    printf "%2d %10d \n", $_, bell_num($_);
}

# =============== TESTS ==============================
=pod
ok bell_num(4) == 15, "main test 1";
ok bell_num(1) == 1, "main test 2";
ok dup([2, 2]) == 2, "test dup 1";
ok dup([2, 1, 1]) == 1, "test dup 2";
ok dup([4]) == 1 , "test dup 3";
ok process_combin(4, [2, 2]) == 6, "test process_combin 1";
ok process_combin(4, [3]) == 4, "test process_combin 2";
ok bell_num(7) == 877, "main test 3";
