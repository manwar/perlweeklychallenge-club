#!/usr/bin/perl

# Challenge 189
#
# Task 1: Greater Character
# Submitted by: Mohammad S Anwar
#
# You are given an array of characters (a..z) and a target character.
#
# Write a script to find out the smallest character in the given array
# lexicographically greater than the target character.
# Example 1
#
# Input: @array = qw/e m u g/, $target = 'b'
# Output: e
#
# Example 2
#
# Input: @array = qw/d c e f/, $target = 'a'
# Output: c
#
# Example 3
#
# Input: @array = qw/j a r/, $target = 'o'
# Output: r
#
# Example 4
#
# Input: @array = qw/d c a f/, $target = 'a'
# Output: c
#
# Example 5
#
# Input: @array = qw/t g a l/, $target = 'v'
# Output: v

use Modern::Perl;

sub greater_char {
    my($list, $char)=@_;
    my @list=grep {$_ gt $char} sort @$list;
    return @list ? $list[0] : $char;
}

@ARGV==2 or die "usage: ch-1.pl chars ch\n";
my @list=split //, shift;
my $char=shift;
say greater_char(\@list, $char);
