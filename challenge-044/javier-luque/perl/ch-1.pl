#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use feature qw /say/;

my $numbers = '123456789';
check_numbers('', $numbers, 100);

sub check_numbers {
    my ($n, $nums, $goal) = @_;

    if ($nums) {
        my ($n2, $new_numbers) = split('', $nums, 2);
        check_numbers($n . '+' . $n2, $new_numbers, $goal);
        check_numbers($n . '-' . $n2, $new_numbers, $goal);
        check_numbers($n . $n2, $new_numbers, $goal);
    } else {
        my $total = eval $n;
        say $n if ($total == $goal)
    }
}
