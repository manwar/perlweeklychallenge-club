#!/opt/perl/bin/perl -pla

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
# Run as: perl -pla ch-1.pl < input-file
#

#
# Third week in a row with some trivial bit fiddling... 
# 
# Restricting ourselves to 8 bit input doesn't make the code any simpler
# -- this code works up to $m = 2^63 - 1,  $n = 63 (or 2^31 - 1/31 if
# you're running a 32-bit integer perl).
#

$_=$F[0]^1<<--$F[1]


__END__
