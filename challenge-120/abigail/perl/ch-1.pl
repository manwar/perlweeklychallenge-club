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
# This is just week 119 with different constants
#


while (<>) {
    say + ($_ & 0x55) << 1  # Odd  bits shifted one the right 
        | ($_ & 0xAA) >> 1  # Even bits shifted one to the left
}

