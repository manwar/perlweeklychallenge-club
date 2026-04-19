#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    say s/[^\s\pL]+//gr      =~   # Remove non-letters, but keep the spaces
        s/^\s+//r            =~   # Remove leading spaces
        s/\s+$//r            =~   # Remove trailing spaces
        s/(.*)/\L$1/r        =~   # All lower case
        s/\s+(\pL)/\u$1/gr   =~   # Capitalize first letter of each word,
                                  # and delete the space proceeding it
        s/^/#/r              =~   # Add leading '#'
        s/.{100}\K.*//r           # Remove all characters after the 100th.
}
        

__END__
