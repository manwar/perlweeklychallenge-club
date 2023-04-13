#!/usr/bin/perl
use strict;
use warnings;

my $script_name = $0;

open(my $fh, '<', $script_name) or die "Could not open file '$script_name' $!";
while (my $line = <$fh>) {
    print $line;
}
close($fh);

