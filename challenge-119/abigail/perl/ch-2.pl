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

sub next_num ($prev_num) {
    #
    # First, replace any trailing 3's with 1's, incrementing the
    # digit which comes before.
    # Then replace any trailing sequence of 1s with 12121... of the same
    # length.
    # Note we prepend the incoming number with "00" so we can anchor
    # against it; we remove any leading 0s at the end.
    #
    "00$prev_num"                                                      =~
       s!([012])(3*)$!($1 + 1) . (1 x length $2)!re                    =~
       s!([023])((?:11)+)(1?)$!$1  . (12 x ((length $2) / 2)) . $3!re  =~
       s!^0+!!r;
}

while (<>) {
    my $n = 0;
    $n = next_num $n for 1 .. $_;
    say $n;
}
