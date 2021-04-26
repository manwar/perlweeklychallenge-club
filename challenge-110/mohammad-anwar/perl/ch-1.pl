#!/usr/bin/perl

use strict;
use warnings;

my $FILE = $ARGV[0];
die "ERROR: Missing input file.\n" unless defined $FILE;

open(my $fh, '<:encoding(utf8)', $FILE)
    or die "ERROR: Unable to open $FILE: $!\n";

while (my $row = <$fh>) {
    chomp $row;

    #
    # I got the following regex works fine against the test data
    # when used on regex101.com
    #
    # /^\+?|(\()?\d{2}\d{2}?\1?\s\d{10}$/
    #
    # But For some strange reason, it didn't work here.
    #
    # So I had to get the following instead.
    #

    if ( ($row =~ /\+\d{2}\s\d{10}/)   ||
         ($row =~ /\d{4}\s\d{10}/)     ||
         ($row =~ /\(\d{2}\)\s\d{10}/)
       ) {
        print "$row\n";
    }
}

close($fh);
