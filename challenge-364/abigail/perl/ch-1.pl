#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    s{(?| (1[0-9]|2[0-6])  \#    # Capture a number 10 - 26 followed by
                                 # a hash, and store the number in $1
        | ([1-9]))}              # Or capture a number 1 - 9, and store it in $1
      {chr $1 - 1 + ord 'a'}gex; # Replace it with the offset from 'a'.
    print;
}

__END__
