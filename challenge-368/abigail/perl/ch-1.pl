#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    my ($input, $digit) = split;
    #
    # We will remove the first occurrence of the given digit which is
    # followed by a larger digit -- if this fails, we remove the last
    # occurrence of the given digit.
    # To find the first occurrence of the given digit, followed by a
    # larger digit, note that a digit larger than N must be in the range N-9,
    # but cannot be N: we can write this as (?[[$digit-9] - [$digit]]); this
    # does the right thing if $digit is 9.
    # To find the last occurrence of the given digit, we use .* to skip as
    # far ahead as possible. By using the \K operator, the part of the
    # string matched by .* will not be replaced.
    #
    $input =~ s/$digit(?=(?[[$digit-9] - [$digit]]))// ||
    $input =~ s/.*\K$digit//;
    say $input;
}

__END__
