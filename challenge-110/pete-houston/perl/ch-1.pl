#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 11001.pl
#
#        USAGE: ./11001.pl < file_of_nums.txt
#
#  DESCRIPTION: Echo only valid phone numbers
#
#        NOTES: See POD for interpretation of the task
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 26/04/21
#===============================================================================

use strict;
use warnings;

=head1 Assumptions

Given the description of the problem there are a number of assumptions
which must be made when constructing a solution. Everyone must address
these ambiguities whether consciously or otherwise.

=over

=item Whitespace

In the definition of acceptable formats, the first format has a double
whitespace between the IDC and the remainder whereas the other formats
have a single whitespace there. In the sample inputs, none of the given
lines have a double whitespace and yet the outputs show lines which can
only match the first format.

Possible conclusions are

=over

=item all whitespace is to be ignored

=item all whitespace is to be collapsed

=item the spec has a typo and only single whitespaces are valid

=back

The first of these seems unlikely as it would permit sufficiently large
whole numbers to be interpreted as phone numbers.

The significance of multiple whitespaces is unknown in the data corpus
but given the standard approach of being liberal in what one accpets
and strict in what one produces it would be reasonable to think that
collapsing sounds like the best compromise. Along similar lines I will
also collapse any whitespace that matches C<\s>.

There is also the matter of leading whitespace in the output. One line
of output (with the 3-character IDC) has a leading space. We assume that
this fomatting is required.

=item Multiple numbers per line

We are told nothing about the input file. The sample input has 1
possible valid entry per line but can we assume this for all input
files?

As we are asked to display the numbers, not the lines then let us cater
for the possibility that there may be any number of matches on any given
line.

=back

=cut

# Slurp
undef $/;
my $in = <STDIN>;

# Match
my @valid = $in =~ /(?:\+\d\d|\(\d\d\)|\d{4})\s+\d{10}/g;

# Normalise
for (@valid) {
	# Collapse multiple whitespace, convert tabs and newlines
	s/\s+/ /g;
	# Leading whitespace for +nn
	s/^\+/ +/;
}

# Output
print join ("\n", @valid), "\n";
