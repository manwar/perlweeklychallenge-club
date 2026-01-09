#!/usr/bin/env perl

use strict;
use warnings;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK2

while ( <DATA> ) {
    my @row = split(/\t/, $_);
    chomp( @row );
    next if ( scalar( @row ) < 3 );
    print "Input: \@ints = (" . join(", ", @row), ")\n";

    # a priori pretend each record will pass the tests
    my $is_a_mountain = 'true'; 

    # To detect the desired pattern we are going to keep track of the
    # preceding element in the array.  Since there is no element before
    # index [0] we are going to check this now
    my $preceding_element_is = $row[0] > $row[1] ? 'higher' : 'lower';

    # If the current array matches the pattern then the value in
    # $preceding_element_is "switches" from 'lower' to 'higher' once
    # and exactly once, during the analysis loop, and we keep track to
    # see IF: it switches at all, AND, how many times it switches
    my $switch_count = 0;
    while ( my ( $i, $v ) = each( @row ) ) {

	# I decided to test this at the start of each iteration, I suspect
	# some folks would test it at the end of each cycle.
        last if $is_a_mountain eq 'false';

        # We already evaluated the value in $row[0]
        if ( $i > 0 ) {
	    if ( $row[$i-1] > $v ) {
		$switch_count++ if $preceding_element_is eq 'lower';
                $preceding_element_is = 'higher';
	    }
            elsif ( $row[$i-1] < $v ) {
		$switch_count++ if $preceding_element_is eq 'higher';
                $preceding_element_is = 'lower';
	    }
	    else {
                # The task does not permit a data record
		# where the value in two adjacent array elements are equivalent
		# so this condition immediately triggers failure
		$preceding_element_is = 'same';
                $is_a_mountain = 'false';
	    }
	}
	if ( $switch_count > 1 ) {

	    # If the pattern switches a second time
	    # it triggers a failure
            $is_a_mountain = 'false';
	}
    }

    print "Output: ";
    if ( $is_a_mountain eq 'true' and $switch_count == 1 ) {
        print "true\n\n";
    }
    else {
        print "false\n\n";
    }
}


=pod

=head1 COMMENTS

In order for an array of numbers to meet all of the criteria for a so-called
"Mountain Array" it must contain no adjacent repeated numbers, one
maximum value that is in neither the first nor the last element, and
each array element prior to the max must be larger than the preceding element.
Each element after the max must be smaller than the preceding element.

In this script, starting with the second element in the array, we
determine if it's value is either higher, lower, or the same as the
preceding element.  By applying these criteria, and monitoring
if and when that the results of the comparisons "switch" (in this case
from lower to higher), we can determine if the fields in the current
record match the desired pattern (or "shape") of the data.  Here are
two different depictions of the pattern.  In this case using an array
of seven elements from Example #3 in this weekly challenge.



 | index | value | preceding_element_is |
 |--------------------------------------|
 | 0     | 0     | --                   |
 | 1     | 2     | lower                |
 | 2     | 4     | lower                |
 | 3     | 6     | lower                |
 | 4     | 4     | higher               |
 | 5     | 2     | higher               |
 | 6     | 0     | higher               |


Here is an alternative, crude, visualization of what a
Mountain Array would "look" like:


                 lower
           lower       higher
     lower                   higher
 ---                                higher


=cut


__DATA__
1	2	3	4	5
0	2	4	6	4	2	0
5	4	3	2	1
1	3	5	5	4	2
1	3	2
    
