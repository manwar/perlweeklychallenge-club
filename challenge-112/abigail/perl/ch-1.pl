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
    chomp;

    # Remove duplicate slashes
    s !/\K/+!!g;

    # Add a trailing slash; this makes it easier to deal
    # with the cases below.
    $_ .= "/";

    # Remove single period
    s !/\.(?=/)!!g;

    # Remove double period
    1 while s !/[^/]+/\.\.(?=/)!!;

    # Remove any leading /../
    1 while s !^/\.\./!/!;

    # Remove trailing slashes
    s !/+$!!;

    say $_ || '/';
}
