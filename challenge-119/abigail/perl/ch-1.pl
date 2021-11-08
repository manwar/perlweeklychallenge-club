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
# We can solve this by just shifting some bits around.
# There is also no need to restrict ourselves to numbers less than 256.
#


while (<>) {
    say + ($_ & ~0xFF)       # Number with the last two nibbles 0.
        | ($_ &  0x0F) << 4  # Last nibble shifted 4 bits to the left.
        | ($_ &  0xF0) >> 4  # Penultimate nibble shifted 4 bits to the right.
}

