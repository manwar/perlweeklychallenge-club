#!/usr/bin/env perl

use v5.38;
use Lingua::EN::Numbers qw(num2en);

=head1 COMMENTS

Searching the internet told me that the Perl module in CPAN named
Lingua::EN::Numbers was designed to convert or transform numerals into
the english word for that number.

According to the modules POD the method 'num2en' should do what we
want.  I have never used this module previously, but it was
straightforward and easy to install.

=cut


my @inputs = ( [6, 7, 8, 9 ,10], [-3, 0, 1000, 99], [1, 2, 3, 4, 5], [0, -1, -2, -3, -4], [100, 101, 102], );

foreach my $input ( @inputs ) {

    # Since we want to convert each element in the array from a numeral into
    # its english language equivalent, we could use a for loop, but it is
    # convenient to use Perl's built-in map() function (less typing?)
    # Next the challenge asks us to sort the english language words
    # before printing out the newly sorted numerals in their new order.
    # To me, this screams for a Schwartzian Transform
    # It can be clearer to read the steps up from the bottom

                  # STEP_3: extract the second element in the anonymous array
                  # which contains the original numeral
    my @output =  map  { $_->[1] }

	          # STEP_2: use the first element in the anonymous array
	          # to sort the words lexicographically
	          sort { $a->[0] cmp $b->[0] }

		  # STEP_1: transform each element in our array from a numeral
		  # into an english word, and store them together in a new anonymous
		  # array (one anonymous array for each element in the starting array)
                  map  { [num2en($_), $_] } $input->@*;	

    print "Input: (", join(", ", $input->@*), ")\n";
    print "Output: (", join(", ", @output ), ")\n\n";
}

exit;

