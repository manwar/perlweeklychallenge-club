#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 strs...\n";

say is_circular(@ARGV) ? "true" : "false";

sub is_circular {
    my(@words) = @_;
    for my $i (0 .. $#words - 1) {
        if (substr($words[$i], -1, 1) ne substr($words[$i+1], 0, 1)) {
            return 0;
        }
    }
    return 1;
}
