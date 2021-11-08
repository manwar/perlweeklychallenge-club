#!/usr/bin/perl -s

use v5.16;
use warnings;
$| = 1;

# The task states "You are given a *stream* of numbers" which is taken
# to be different from a list.  Thus we expect the data to be provided
# by a file (or STDIN), which could be a pipe.
#
# Call "./ch-1a.pl | ./ch-1.pl" for the task's example.

my ($s, $n);
while (<>) {
    say +($s += $_) / ++$n;
}
