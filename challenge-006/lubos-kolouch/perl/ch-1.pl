#!/usr/bin/perl

use strict;
use warnings;

=head1 DESCRIPTION

This script takes a list of numbers from command line and print the same in the compact form.

For example, if you pass “1,2,3,4,9,10,14,15,16” then it should print the compact form like “1-4,9,10,14-16”. 

=cut

# Get the list of numbers from command line
my @numbers = @ARGV;

# Sort the list of numbers in ascending order
@numbers = sort { $a <=> $b } @numbers;

# Initializing variables
my @compact_list;
my $first_num = $numbers[0];
my $last_num  = $numbers[0];

# Generate the compact list
foreach my $num (@numbers) {
    if ( $num == $last_num + 1 ) {

        # If the current number is 1 more than the last number,
        # update the last number
        $last_num = $num;
    }
    else {
        # If the current number is not 1 more than the last number,
        # add the range of numbers to the compact list
        if ( $first_num == $last_num ) {
            push @compact_list, $first_num;
        }
        else {
            push @compact_list, "$first_num-$last_num";
        }

        # Reset the variables
        $first_num = $num;
        $last_num  = $num;
    }
}

# Add the last range of numbers to the compact list
if ( $first_num == $last_num ) {
    push @compact_list, $first_num;
}
else {
    push @compact_list, "$first_num-$last_num";
}

# Print the compact list
print join( ',', @compact_list );

=head1 TESTING

=over 4

=item *

Input: 1,2,3,4,9,10,14,15,16

Expected Output: 1-4,9,10,14-16

=back

=cut
