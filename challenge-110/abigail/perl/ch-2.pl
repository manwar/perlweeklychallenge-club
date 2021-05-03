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
# We make the assumption the input has the same number 
# of fields on each line.
#

#
# Read in the data, split into fields, add the fields to a set strings,
# placed in an array @;. Add commas after each field.
#
map {$- = 0; $; [$- ++] .= "$_," for /[^,\n]+/g} <>;

#
# Remove trailing commas, print lines.
#
chop, say for @;

__END__
