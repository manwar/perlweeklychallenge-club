#!/usr/bin/perl
use strict;
use warnings;

sub find_missing_row {
    my ($filename) = @_;
    open my $fh, '<', $filename or die "Could not open $filename: $!";
    my @rows = map { (split /,/, $_)[0] } <$fh>;
    close $fh;
    my %lines = map { $_ => 1 } 1..15;
    delete $lines{$_} for @rows;
    return (keys %lines)[0];
}

# Test case: assuming the file is named 'file.txt'
print find_missing_row('file.txt'), "\n";  # Should print the missing line number

