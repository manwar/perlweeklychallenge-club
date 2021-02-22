#!/usr/bin/perl

# THE WEEKLY CHALLENGE - 091
# TASK #1: Count Number
#
# You are given a positive number $N. Write a script to count number and
# display as you read it.

# Numeric recursive solution:
# A solution without regular expressions, where the last digit is extracted
# by the reminder of the division by 10, and the value divided by 10. This
# process is repeated while the last digit is the same, counting the number
# of repetitions. The function then recurses to display the count of the
# previous digits, and then displays its own count.

use strict;
use warnings;

my $N = shift;
read_number($N);

sub read_number {
    my($n) = @_;
    read_number_($n);
    print "\n";
}

sub read_number_ {
    my($n) = @_;
    return unless $n > 0;   # end condition

    # count number of equal digits at the end
    my $digit = $n % 10;
    my $count = 0;
    while ($n > 0 && ($n % 10) == $digit) {
        $n = int($n / 10);
        $count++;
    }

    # recurse to print top part
    read_number_($n);

    # print last digits
    print $count,$digit;
}
