#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $file = shift or die "You must specify a file name\n";

    # Open the file for reading
    open( my $fh, '<:encoding(UTF-8)', $file ) or die "Cannot open $file: $!\n";
    my %lines = ();

    # Read the file, and get the line numbers
    while ( my $line = <$fh> ) {
        if ( my ($number) = ( $line =~ /^(\d+),/ ) ) {
            $lines{$number} = 1;
        }
    }

    # Count up from one to find the missing line
    my $number = 0;
    while ( ++$number ) {
        if ( not exists $lines{$number} ) {
            say $number;
            return;
        }
    }
}

main(@ARGV);

