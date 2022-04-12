#!/usr/bin/env perl

# Challenge 160
#
# TASK #1 › Four Is Magic
# Submitted by: Mohammad S Anwar
# You are given a positive number, $n < 10.
#
# Write a script to generate english text sequence starting with the English
# cardinal representation of the given number, the word ‘is’ and then the
# English cardinal representation of the count of characters that made up the
# first word, followed by a comma. Continue until you reach four.
#
#
# Example 1:
# Input: $n = 5
# Output: Five is four, four is magic.
#
# Example 2:
# Input: $n = 7
# Output: Seven is five, five is four, four is magic.
#
# Example 3:
# Input: $n = 6
# Output: Six is three, three is five, five is four, four is magic.

use Modern::Perl;
use Lingua::EN::Numbers qw(num2en);

say sequence(shift||1);

sub sequence {
    my($n) = @_;
    my @out;
    while ($n != 4) {
        my $num_en = num2en($n);
        my $len = length($num_en);
        my $len_en = num2en($len);

        push @out, "$num_en is $len_en";
        $n = $len;
    }

    push @out, "four is magic.";
    $out[0] =~ s/(\w)/\U$1/;
    return join(", ", @out);
}
