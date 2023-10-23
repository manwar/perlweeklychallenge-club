#!/usr/bin/perl
use warnings;
use strict;

##
## You are given two arrays of strings.
##
## Write a script to find out if the word created 
## by concatenating the array elements is the same.
##
## Example: ("ab", "c") and ("a", "bc") are the same.
##          ("ac", "b") and ("ab", "c") are not.
##
##
## LIMITS:
## Only two arrays to compare.
## But they can have as many string parts as they'd like, from 1 to some huge number.
##

my @arr1 = ("ab", "c");
my @arr2 = ("a", "bc");
main(\@arr1, \@arr2);

@arr1 = ("ab", "c");
@arr2 = ("ac", "b");
main(\@arr1, \@arr2);

@arr1 = ("ab", "cd", "e");
@arr2 = ("abcde");
main(\@arr1, \@arr2);


sub main {

	my @arr1 = @{ shift() };
	my @arr2 = @{ shift() };

	show_inputs(\@arr1, \@arr2);
    my $combined1 = combine_arrays(\@arr1);
    my $combined2 = combine_arrays(\@arr2);
    my $results = compare_strings($combined1, $combined2);
    show_output( $results );
 
}

sub show_inputs {

	my @arr1 = @{ shift() };
	my @arr2 = @{ shift() };

	print 'Input: @arr1 = ' . ( pretty_print_array(\@arr1) ) . "\n";
	print 'Input: @arr2 = ' . ( pretty_print_array(\@arr2) ) . "\n";
	
	return;

}

sub show_output {

	my $final_results = shift();

	print "Output: " . $final_results . "\n\n";

}


sub combine_arrays {

	my @arr = @{ shift() };
	my $combined_string = '';

	map{ $combined_string .= $_; } @arr;

	return $combined_string;
}


sub compare_strings {

	my ($str1, $str2) = @_;
	return  $str1 eq $str2 ? 'true' : 'false';	

}



sub pretty_print_array {

    ## Total overkill, but I'm new and over-enthusiastic.
    ## In reality, I'd find something on CPAN for this.

    my @array = @{ shift() };
    my $length = scalar @array;
    my $count = 1;

	my $pretty_string = "(";

    foreach my $value(@array) {
        $pretty_string .= '"' . $value . '"';
        $pretty_string .= ", " if $count < $length;
        $count++;
    }

    $pretty_string .= ")";

    return $pretty_string;
}

