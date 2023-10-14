#!/usr/bin/perl 

use strict;
use warnings;

# Week 238, Task 2: Persistence Sort
# I can't explain it in one line.  Go to the website.

## Test Values:
my @first  = (15, 99, 1, 34);
my @second = (50, 25, 33, 22);
my @tests = ( \@first, \@second );

## This is global because I'm a bad person.
## Also, I ran out of time to fix it.
my %steps;

## Runner:
foreach my $array_ref( @tests ) {

	print "BEFORE: ";
	pretty_print_array( $array_ref);

	my @results = persistance_sort( $array_ref );

	print "AFTER: ";
	pretty_print_array(\@results);

	print "\n";

	## The price I pay for the global
	%steps = ();

}


## Basically, main(): 
sub persistance_sort {

	my @array = @{ shift() };

	foreach my $value( @array ) {

		my @array_of_numbers = split(//, $value);
		$steps{$value} = multiply_numbers_recursively($value, 0);

	}
	my @final_results = ();

	foreach my $result (sort compare keys %steps) {
		push(@final_results, $result);
	}

	return @final_results;

}

sub compare {

	## The two level sort function
	## The reason I have a global variable.

	if($steps{$a} < $steps{$b}) {
		return -1;
	} elsif ($steps{$a} == $steps{$b}) {
		return 1 if $a > $b;
		return -1;
	} else {
		return 1
	}

}


sub multiply_numbers_recursively {

	# Recursion Rocks

	my $number = shift();
	my $count  = shift();

	my @list_of_numbers = split(//, $number);
	return $count if scalar(@list_of_numbers) == 1;
	
	my $running_total = 1;
	map{ $running_total *= $_ } @list_of_numbers;
	
	return multiply_numbers_recursively($running_total, ++$count);
}

sub pretty_print_array {

	## I copied-and-pasted this from my solution for Task 1.
	## If I copy-and-paste it again, by law I need to turn
	## it into a library. ;-)

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

