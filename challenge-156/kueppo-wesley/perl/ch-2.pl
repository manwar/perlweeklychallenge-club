#!/usr/bin/env perl

use strict;
use warnings;

### HELPER
# Find all divisors of $n
sub get_divisors {
    my($number, @fdiv, @sdiv) = (shift);

    if ($number > 3) {
        foreach (2..sqrt $number) {
        	if ($number % $_ == 0) {
        		push @sdiv, $number / $_;
        		push @fdiv, $_ if ($number / $_ != $_);
        	}
        }
    }

    (1, @fdiv, reverse @sdiv)
}

### MAIN
sub is_weird {
    my(@track, @subset) = ();
    my($number, $sum) = (shift, 0);
    my @divisors = get_divisors $number;

    $sum += $_ foreach (@divisors);
    if ($sum > $number) {
        my $now = 0;
        LOOP: {
        	foreach (@divisors) {
        		if ($now + $_ == $number) {
        			$now += $_;
        			push @subset, $_;
        			last;
        		} elsif ($now + $_ < $number) {
        			$now += $_;
        			push @subset, $_;
        			push @track, $_;
        		} else {
        			# Backtracking
        			$now = $_;
        			@subset = ($_);
        			foreach (reverse @track) {
        				if ($now + $_ < $number) {
        					$now += $_;
        					push @subset, $_;
        				} elsif ($now + $_ == $number) {
        					$now += $_;
        					push @subset, $_;
        					last LOOP;
        				}
        			}
        			@track = ($_);
        		}
        	}
        }
        if ($now == $number) {
        	print "Output: 1\n";
        	print "proper divisors: @divisors\n";
        	print "subset: @subset => sum = $number\n";
         } else {
        	print "Output: 0\n";
        	print "proper divisors: @divisors\n";
        	print "No subset of these sums to $number\n";
         }
    } else {
        print "Output: 1\n";
        print "Total sum of the divisors = $sum < $number\n";
    }
}

print "Input: ";
my $input = <STDIN>;
is_weird $input;
