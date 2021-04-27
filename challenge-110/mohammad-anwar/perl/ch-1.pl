#!/usr/bin/perl

use strict;
use warnings;

my $FILE = $ARGV[0];
die "ERROR: Missing input file.\n" unless defined $FILE;

open(my $fh, '<:encoding(utf8)', $FILE)
    or die "ERROR: Unable to open $FILE: $!\n";

while (my $row = <$fh>) {
    chomp $row;

    if ( ($row =~ /\+\d{2}\s\d{10}/)   ||
         ($row =~ /\d{4}\s\d{10}/)     ||
         ($row =~ /\(\d{2}\)\s\d{10}/)
       ) {
        print "$row\n";
    }
}

close($fh);
