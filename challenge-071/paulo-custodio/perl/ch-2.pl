#!/usr/bin/env perl

# Challenge 071
#
# TASK #2 › Trim Linked List
# Submitted by: Mohammad S Anwar
# You are given a singly linked list and a positive integer $N (>0).
#
# Write a script to remove the $Nth node from the end of the linked list and
# print the linked list.
#
# If $N is greater than the size of the linked list then remove the first
# node of the list.
#
# NOTE: Please use pure linked list implementation.
#
# Example
# Given Linked List: 1 -> 2 -> 3 -> 4 -> 5
# when $N = 1
# Output: 1 -> 2 -> 3 -> 4
# when $N = 2
# Output: 1 -> 2 -> 3 -> 5
# when $N = 3
# Output: 1 -> 2 -> 4 -> 5
# when $N = 4
# Output: 1 -> 3 -> 4 -> 5
# when $N = 5
# Output: 2 -> 3 -> 4 -> 5
# when $N = 6
# Output: 2 -> 3 -> 4 -> 5

use Modern::Perl;

my $n = shift||1;
my $list;
while (@ARGV) {
    $list = [pop @ARGV, $list];
}
my $len = list_len($list);
my $remove = $n > $len ? 0 : $len-$n;
$list = remove_n($remove, $list);
show($list);

sub list_len {
    my($list) = @_;
    my $len = 0;
    while ($list) {
        $len++;
        $list = $list->[1];
    }
    return $len;
}

sub remove_n {
    my($remove, $list) = @_;
    if ($remove == 0) {
        return $list->[1];
    }
    else {
        my $p = $list;
        my $last;
        while ($p) {
            if ($remove == 0) {
                $last->[1] = $p->[1];
            }
            $last = $p;
            $p = $p->[1];
            $remove--;
        }
        return $list;
    }
}

sub show {
    my($list) = @_;
    my @out;
    while ($list) {
        push @out, $list->[0];
        $list = $list->[1];
    }
    say join(" ", @out);
}
