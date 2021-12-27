#!/usr/bin/perl

use strict;
use warnings;

number_divisors_task(10, 8);

sub number_divisors_task {
    my ($number_count, $divisor_count) = @_;

    my @desired_numbers;
    my $i = $divisor_count;
    while (@desired_numbers < $number_count) {
    	if (number_of_divisors($i) == $divisor_count) {
    		push @desired_numbers, $i;
    	}
    	$i++;
    }
    print "Lowest 10 positive integers having exactly 8 divisors\n";
    print join("\n", @desired_numbers);
}

sub number_of_divisors {
    my ($num) = @_;
    my $count = 0;
    foreach my $divisor (1 .. $num) {
    	if ($num % $divisor == 0) {
    		$count++;
    	}
    }
    return $count;
}
