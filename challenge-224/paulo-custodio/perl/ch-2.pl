#!/usr/bin/env perl

# Challenge 224
#
# Task 2: Additive Number
# Submitted by: Mohammad S Anwar
# You are given a string containing digits 0-9 only.
#
# Write a script to find out if the given string is additive number. An additive
# number is a string whose digits can form an additive sequence.
#
# A valid additive sequence should contain at least 3 numbers. Except the first
# 2 numbers, each subsequent number in the sequence must be the sum of the
# preceding two.
#
#
# Example 1:
# Input: $string = "112358"
# Output: true
#
# The additive sequence can be created using the given string digits: 1,1,2,3,5,8
# 1 + 1 => 2
# 1 + 2 => 3
# 2 + 3 => 5
# 3 + 5 => 8
# Example 2:
# Input: $string = "12345"
# Output: false
#
# No additive sequence can be created using the given string digits.
# Example 3:
# Input: $string = "199100199"
# Output: true
#
# The additive sequence can be created using the given string digits: 1,99,100,199
#  1 +  99 => 100
# 99 + 100 => 199

use Modern::Perl;

@ARGV==1 or die "Usage: $0 num\n";
my $num = shift;
my $result = 0;
is_addictive_seq(\$result, [], $num);
say $result ? "true" : "false";

sub is_addictive_seq {
    my($result, $seq, $num) = @_;

    if (@$seq >= 3 && $seq->[-3]+$seq->[-2]!=$seq->[-1]) {
        return;                 # not a sequence
    }
    elsif (@$seq >= 3 && $num eq '') {
        $$result = 1;           # found solution
        return;
    }
    elsif ($num eq '') {
        return;                 # no solution
    }
    else {                      # add one more number to sequence
        for my $i (1..length($num)) {
            is_addictive_seq($result, [@$seq, 0+substr($num,0,$i)], substr($num,$i));
        }
    }
}
