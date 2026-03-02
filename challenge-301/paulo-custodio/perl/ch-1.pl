#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say largest_num(@ARGV);

sub largest_num {
    my(@nums) = @_;
    my $largest = 0;

    my $find_largest;
    $find_largest = sub {
        my($prefix, $pending) = @_;
        if (@$pending == 0) {
            my $num = 0+$prefix;
            $largest = $num if $largest < $num;
        }
        else {
            for my $i (0 .. $#$pending) {
                my $new_prefix = $prefix . $pending->[$i];
                my @new_pending = @$pending;
                splice(@new_pending, $i, 1);
                $find_largest->($new_prefix, \@new_pending);
            }
        }
    };

    $find_largest->("", \@nums);
    return $largest;
}
