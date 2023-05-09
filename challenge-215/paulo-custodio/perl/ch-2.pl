#!/usr/bin/perl

# Challenge 215
#
# Task 2: Number Placement
# Submitted by: Mohammad S Anwar
#
# You are given a list of numbers having just 0 and 1. You are also given
# placement count (>=1).
#
# Write a script to find out if it is possible to replace 0 with 1 in the
# given list. The only condition is that you can only replace when there
# is no 1 on either side. Print 1 if it is possible otherwise 0.
# Example 1:
#
# Input: @numbers = (1,0,0,0,1), $count = 1
# Output: 1
#
# You are asked to replace only one 0 as given count is 1.
# We can easily replace middle 0 in the list i.e. (1,0,1,0,1).
#
# Example 2:
#
# Input: @numbers = (1,0,0,0,1), $count = 2
# Output: 0
#
# You are asked to replace two 0's as given count is 2.
# It is impossible to replace two 0's.
#
# Example 3:
#
# Input: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3
# Output: 1

use Modern::Perl;

sub can_place {
    my($nums, $count) = @_;
    my $str = join '', @$nums;
    for (1 .. $count) {
        if (!($str =~ s/000/010/)) {
            return 0;
        }
    }
    return 1;
}

@ARGV==2 or die "usage: ch-2.pl 1,0,... n\n";
my @nums = split /,/, shift;
my $count = shift;
say can_place(\@nums, $count);
