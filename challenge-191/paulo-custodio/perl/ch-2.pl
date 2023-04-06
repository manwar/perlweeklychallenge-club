#!/usr/bin/perl

# Challenge 191
#
# Task 2: Cute List
# Submitted by: Mohammad S Anwar
#
# You are given an integer, 0 < $n <= 15.
#
# Write a script to find the number of orderings of numbers that form a cute list.
#
# With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of
# @list is cute if for every entry, indexed with a base of 1, either
#
# 1) $list[$i] is evenly divisible by $i
# or
# 2) $i is evenly divisible by $list[$i]
#
# Example
#
# Input: $n = 2
# Ouput: 2
#
# Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.
# Therefore we can have two list i.e. (1,2) and (2,1).
#
# @list = (1,2) is cute since $list[1] = 1 is divisible by 1 and $list[2] = 2
# is divisible by 2.

use Modern::Perl;

sub cute_list_ {
    my($count, $prefix, $pending)=@_;
    if (@$pending==0) {
        $$count++;
    }
    else {
        my @prefix=@$prefix;
        my $div=scalar(@prefix)+1;
        for my $i (0..$#$pending) {
            my $n=$pending->[$i];
            if ($n%$div==0 || $div%$n==0) {
                my @copy=@$pending;
                splice(@copy,$i,1);
                cute_list_($count,[@prefix,$n],\@copy);
            }
        }
    }
}

sub cute_list {
    my($n)=@_;
    my $count=0;
    cute_list_(\$count,[],[1..$n]);
    return $count;
}

say cute_list(shift);
