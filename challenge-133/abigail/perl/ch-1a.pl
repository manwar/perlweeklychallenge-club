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
# Run as: perl ch-1a.pl < input-file
#

#
# Unlike ch-1.pl, this is a solution which only avoids sqrt (and int for
# that matter)
#
# Given that:
#
#    * sqrt (a)  == a^(1/2)
#    * a^b       == exp (log (a^b)), a > 0
#    * log (a^b) == b * log (a),     a > 0
#
# We can write sqrt (N) as exp (log (N) / 2)
#
# We avoid using int() by just stripping the decimal point and 
# anything following it using a regular expression.
#

say (exp (log ($_) / 2) =~ s/\..*//r) while <>;
