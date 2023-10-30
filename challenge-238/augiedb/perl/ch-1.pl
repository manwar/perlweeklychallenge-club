#!/usr/bin/perl
use strict;
use warnings;

# Week 238, Task 1: Running Sum
# Given an array, output an array of the running sum.

# Test Data:
my @test1 = (1, 2, 3, 4, 5);
my @test2 = (1, 1, 1, 1, 1);
my @test3 = (0, -1, 1, 2);
my @array_examples = (\@test1, \@test2, \@test3);


print "Running Sum Code Results:\n";
print "=========================\n\n";

foreach my $array_ref (@array_examples) {

	print "Array: " ;
	pretty_print_array( $array_ref );

	my @results = show_running_sum($array_ref);

	print "Results: ";
	pretty_print_array(\@results);
	
	print "\n";

}

##
## Subroutines
##

sub show_running_sum {

	## Ultimately, this is the heart of the solution

	my @array = @{ shift() };
	my $sum = 0;

	return map{ $sum += $_ } @array;

}

sub pretty_print_array {

	## Total overkill, but I'm new and over-enthusiastic.
	## In reality, I'd find something on CPAN for this.

	my @array = @{ shift() };
	my $length = scalar @array;
	my $count = 1;

	print "(";

	foreach my $value(@array) {
		print $value;
		print ", " if $count < $length;
		$count++;
	}

	print ")\n";

	return;
}

