#!/usr/bin/env perl

# use generate_files.pl to create test files
# where the missing line number is _not_ 
# _necessarily_ the same as the file number.

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum };

for my $file (@ARGV) {
    next unless -f $file;
    my $row = missing_row($file);
    say join "\t", $row, $file;
}

sub missing_row( $file ) {
    if ( -f $file && open my $fh, '<', $file ) {
        my @targets = map { $_ } 0 .. 15;
        my @x       = map { chomp $_; $_ } <$fh>;
        close $fh;
        for my $l (@x) { my ($d) = split /,/, $l; $targets[$d] = 0; }
        return sum @targets;
    }
    return 'none';
}
