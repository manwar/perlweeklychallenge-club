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
# Run as: perl ch-1.pl < input-file
#

#
# More efficient is to store the binary representation of the number
# in a variable, and see whether it's the same as its reverse, but
# using a pattern turns it into a one liner.
#

say sprintf ("%b" => $_) =~ /^(([01])(?1)\g{2}|[01]?)$/ || 0 while <>;
