#!/usr/bin/env perl

# Perl Weekly Challenge 355 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/

use Modern::Perl;

@ARGV or die "Usage: $0 nums...\n";

say is_mountain(@ARGV) ? "true" : "false";

sub is_mountain {
    my(@nums) = @_;
    return 0 if @nums < 3;
    my $last = shift(@nums);
    return 0 if $nums[0] <= $last;
    my $climbing = 1;
    while (@nums) {
        if ($climbing && $nums[0] > $last) {    # climb
            $last = shift @nums;
        }
        elsif ($climbing && $nums[0] < $last) { # descend
            $climbing = 0;
            $last = shift @nums;
        }
        elsif ($climbing) {                     # flat
            return 0;
        }
        elsif (!$climbing && $nums[0] < $last) {# descend
            $last = shift @nums;
        }
        else {
            return 0;                           # clim or flat
        }
    }
    return !$climbing;
}
