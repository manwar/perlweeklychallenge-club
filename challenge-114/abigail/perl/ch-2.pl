#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

#
# We will look at the end of the binary expansion of the input number.
# In particular, we're interested in the last group of 1s. Any positive
# integer ends when written in binary as:
#
#     011...1100...00
#
# with 1 or more 1s, and 0 or more 0s at the end (note that we might
# need to add a leading 0).
#
# The next number with the same amount of bits can be found by swapping
# the '01' pair, and swapping the sequences of 1s and 0s.
#
# Code wise, if the input number (after turning it into a binary
# representation and after adding a leading 0) matches /^(.*)(01)(1*)(0*)$/,
# the binary representation of the wanted output number is "${1}10${2}${3}".
#
# We will be using 'sprintf "0b0%b"' to get the binary representation of
# a number (including a leading 0 and a leading "0b"), and 'oct' to go
# from a binary representation back to a number (for which we need the
# leading "0b").

say oct sprintf ("0b0%b" => $_) =~ s {01(1*)(0*)$} {10$2$1}r while <>;

__END__
