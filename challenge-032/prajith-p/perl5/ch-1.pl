#!/usr/bin/perl

use strict;
use warnings;
use feature qw<say>;

use Data::Dumper;

my %counts = ();

sub Count {
    my $file = shift;
    open(my $fh, '<', $file) or warn $!;
    while (my $line = <$fh>) {
        chomp $line;
        next unless length $line;
        $counts{$line} += 1;
    }
    close($fh);
}

for my $file (@ARGV) {
    Count($file);
}

foreach my $k ( sort { $counts{$b} <=> $counts{$a}} keys %counts) {
    say $k . ',' . $counts{$k};
}
