#!/usr/bin/env perl

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
