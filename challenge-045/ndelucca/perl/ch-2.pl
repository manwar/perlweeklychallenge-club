#!/usr/bin/perl
# Source Dumper

# Write a script that dumps its own source code.

# For example, say, the script name is ch-2.pl then the following command should returns nothing.

# $ perl ch-2.pl | diff - ch-2.pl

use strict;
use warnings;

# We can add whatever we want, anywhere

open(my $fh, "<", __FILE__) || die "Couldn't open $0 for reading because: $! ";

print <$fh>;

close($fh);

# perl ch-2.pl | diff - ch-2.pl
#
