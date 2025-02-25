#!/usr/bin/env perl

# Challenge 184
#
# Task 2: Split Array
# Submitted by: Mohammad S Anwar
#
# You are given list of strings containing 0-9 and a-z separated by space only.
#
# Write a script to split the data into two arrays, one for integers and one for
# alphabets only.
# Example 1
#
# Input: @list = ( 'a 1 2 b 0', '3 c 4 d')
# Output: [[1,2,0], [3,4]] and [['a','b'], ['c','d']]
#
# Example 2
#
# Input: @list = ( '1 2', 'p q r', 's 3', '4 5 t')
# Output: [[1,2], [3], [4,5]] and [['p','q','r'], ['s'], ['t']]

use Modern::Perl;

sub split_one {
    my(@in) = @_;
    my(@num, @letters);
    for (@in) {
        if (/^\d+$/) {
            push @num, $_;
        }
        else {
            push @letters, $_;
        }
    }
    return \@num, \@letters;
}

sub split_array {
    my(@a) = @_;
    my(@num, @letters);
    for (@a) {
        my($this_num, $this_letters) = split_one(split ' ', $_);
        push @num, $this_num if @$this_num;
        push @letters, $this_letters if @$this_letters;
    }
    my @result = (\@num, \@letters);
    return @result;
}

sub print_result {
    my($num, $letters) = @_;
    print "[", join(", ", map {"[".join(",", @$_)."]"} @$num), "]";
    print " and ";
    print "[", join(", ", map {"[".join(",", map {"'$_'"} @$_)."]"} @$letters), "]";
    print "\n";
}

@ARGV or die "usage: ch-2.pl list...\n";
print_result(split_array(@ARGV));
