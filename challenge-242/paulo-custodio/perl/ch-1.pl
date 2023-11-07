#!/usr/bin/env perl

# Challenge 242
#
# Task 1: Missing Members
# Submitted by: Mohammad S Anwar
# You are given two arrays of integers.
#
# Write a script to find out the missing members in each other arrays.
#
# Example 1
# Input: @arr1 = (1, 2, 3)
#        @arr2 = (2, 4, 6)
# Output: ([1, 3], [4, 6])
#
# (1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
# (2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).
# Example 2
# Input: @arr1 = (1, 2, 3, 3)
#        @arr2 = (1, 1, 2, 2)
# Output: ([3])
#
# (1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they are same, keep just one.
# (1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).

use Modern::Perl;
use List::Util 'uniq';

@ARGV==2 or die "usage: $0 '(a,b,c)' '(d,e,f)'\n";
my @arr1 = parse(shift);
my @arr2 = parse(shift);

my @not_in1 = not_in(\@arr1, \@arr2);
my @not_in2 = not_in(\@arr2, \@arr1);

say output(\@not_in1, \@not_in2);


sub parse {
    my($text) = @_;
    my @arr = split ' ', $text =~ s/\D/ /gr;
    return @arr;
}

sub output {
    my($arr1, $arr2) = @_;
    my @elems;
    for ($arr1, $arr2) {
        if (@$_) {
            push @elems, "[".join(", ", @$_)."]"
        }
    }
    return "(".join(", ", @elems).")";
}

sub not_in {
    my($arr1, $arr2) = @_;
    my %arr2;
    $arr2{$_}=1 for @$arr2;
    my @not_in;
    push @not_in, $_ for uniq grep {!$arr2{$_}} @$arr1;
    return @not_in;
}
