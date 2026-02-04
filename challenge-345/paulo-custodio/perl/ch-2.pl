#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
my @visitors = last_visitor(@ARGV);
say join ", ", @visitors;

sub last_visitor {
    my(@nums) = @_;
    my @seen;
    my @ans;

    my $x = 0;   # how many -1s in a row BEFORE this one

    for my $n (@nums) {
        if ($n >= 0) {
            unshift @seen, $n;
            $x = 0;   # reset streak
        }
        else {
            # use current x
            if ($x < @seen) {
                push @ans, $seen[$x];
            }
            else {
                push @ans, -1;
            }
            $x++;     # increment streak for next -1
        }
    }
    return @ans;
}
