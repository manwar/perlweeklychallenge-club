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

while (<>) {
    s/^[-+]\s*//g;  # We don't care about signs.
    say /^([0-9]*)([0-9]{3})([0-9]*)$
        (??{length ($1) == length ($3) ? "" : "(*FAIL)"})/x
                      ? $2
      : length () % 2 ? "even number of digits"
      : length () < 4 ? "too short"
      :                 "not an integer";
}
