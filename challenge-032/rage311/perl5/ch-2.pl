#!/usr/bin/env perl

# 032-2
# Write a function that takes a hashref where the keys are labels and the
# values are integer or floating point values. Generate a bar graph of the data
# and display it to stdout.

use 5.030;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

sub graph ($hr, $by_label = 0) {
  my $max_len = length((sort { length $b <=> length $a } keys %$hr)[0]);
  printf "%*s | %s\n", $max_len, $_, '#' x $hr->{$_} for
    sort { $by_label ? $a cmp $b : $hr->{$b} <=> $hr->{$a} } keys %$hr;
}

graph { apple => 3, cherry => 2, banana => 1 };
print "\n";
graph { apple => 14, cherry => 0, banana => 21, durian => 7 }, 1;
print "\n";
graph { apple => -1, cherry => 40, banana => 12, watermelon => 7 }, 1;
print "\n";
graph { apple => 1, cherry => 9, banana => 7 }, 0;


__DATA__

Output:

 apple | ###
cherry | ##
banana | #

 apple | ##############
banana | #####################
cherry |
durian | #######

     apple |
    banana | ############
    cherry | ########################################
watermelon | #######

cherry | #########
banana | #######
 apple | #

