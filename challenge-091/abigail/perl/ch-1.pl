#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Just a one-liner....
#
# Find sequences of identical numbers. Replace them with the length
# of the sequence, and the repeated number. Do this globally. Print result.
#
print s/([0-9])\g{-1}*/length ($&) . $1/egr for <>;

__END__
