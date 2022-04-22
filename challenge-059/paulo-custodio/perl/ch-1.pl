#!/usr/bin/env perl

# Challenge 059
#
# TASK #1 › Linked List
# Reviewed by Ryan Thompson
# You are given a linked list and a value k. Write a script to partition the
# linked list such that all nodes less than k come before nodes greater than or
# equal to k. Make sure you preserve the original relative order of the nodes in
# each of the two partitions.
#
# For example:
#
# Linked List: 1 -> 4 -> 3 -> 2 -> 5 -> 2
#
# k = 3
#
# Expected Output: 1 -> 2 -> 2 -> 4 -> 3 -> 5.

use Modern::Perl;
use HOP::Stream qw( list_to_stream iterator_to_stream head tail );

my($k, @n) = @ARGV;
my $in = list_to_stream(@n);
my $out = iterator_to_stream(partition_it($k, $in));

my @out;
while ($out) {
    my $head = head($out);
    $out = tail($out);
    push @out, $head;
}
say join(" -> ", @out);


sub partition_it {
    my($k, $in) = @_;
    my @pending;
    return sub {
        while ($in) {
            my $head = head($in);
            $in = tail($in);
            if ($head < $k) {
                return $head;
            }
            else {
                push @pending, $head;
            }
        }
        while (@pending) {
            my $head = shift @pending;
            return $head;
        }
        return;
    };
}
