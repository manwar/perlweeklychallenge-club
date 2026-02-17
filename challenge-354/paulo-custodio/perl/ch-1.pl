#!/usr/bin/env perl

use Modern::Perl;

@ARGV>=2 or die "Usage: $0 nums...\n";
my @pairs = min_diff(@ARGV);
print join(", ", map {"[".$_->[0].", ".$_->[1]."]"} @pairs), "\n";

sub min_diff {
    my(@nums) = @_;
    return if @nums < 2;
    @nums = sort {$a <=> $b} @nums;

    # compute minimum difference
    my $min_diff = 1e10;
    for my $i (0 .. $#nums-1) {
        for my $j ($i+1 .. $#nums) {
            my $diff = $nums[$j] - $nums[$i];   # numbers are sorted above
            if ($min_diff > $diff) {
                $min_diff = $diff;
            }
        }
    }

    # collect pairs
    my @pairs;
    for my $i (0 .. $#nums-1) {
        for my $j ($i+1 .. $#nums) {
            my $diff = $nums[$j] - $nums[$i];   # numbers are sorted above
            if ($diff == $min_diff) {
                push @pairs, [$nums[$i], $nums[$j]];
            }
        }
    }
    return @pairs;
}
