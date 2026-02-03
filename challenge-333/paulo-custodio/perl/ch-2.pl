#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say join ", ", dup_zeros(@ARGV);

sub dup_zeros {
    my(@nums) = @_;
    my @out;
    for (@nums) {
        if ($_) {
            push @out, $_;
        }
        else {
            push @out, 0, 0;
        }
        last if @out >= @nums;
    }
    pop @out if @out > @nums;
    return @out;
}
