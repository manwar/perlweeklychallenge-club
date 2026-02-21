#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 strs...\n";
say num_ops(@ARGV);

sub num_ops {
    my(@strs) = @_;
    my $prefix = common_prefix(@strs);
    if ($prefix eq '') {
        return -1;
    }
    else {
        my $ops = 0;
        for (@strs) {
            $ops += length($_) - length($prefix);
        }
        return $ops;
    }
}

sub common_prefix {
    my(@strs) = @_;
    my $prefix = "";
    for my $i (0 .. length($strs[0]) - 1) {
        for (@strs) {
            if (substr($_, $i, 1) ne substr($strs[0], $i, 1)) {
                return $prefix;
            }
        }
        $prefix .= substr($strs[0], $i, 1);
    }
    return $prefix;
}
