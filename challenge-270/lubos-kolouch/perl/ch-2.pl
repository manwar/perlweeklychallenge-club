#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

sub min_cost_to_equal_elements {
    my ($ints_ref, $x, $y) = @_;
    my @ints = @$ints_ref;

    my $min_cost = "inf";
    my $max_val = max(@ints);
    my $min_val = min(@ints);

    print "Initial array: (@ints)\n";
    print "Cost for Level 1 (x): $x\n";
    print "Cost for Level 2 (y): $y\n";

    for my $target ($min_val .. $max_val) {
        my $cost = 0;
        print "\nTrying to make all elements equal to: $target\n";

        for my $num (@ints) {
            my $diff = abs($target - $num);
            print "Difference for element $num to target $target: $diff\n";

            my $cost_addition;
            if ($y < 2 * $x) {
                my $level_2_ops = int($diff / 2);
                my $level_1_ops = $diff % 2;
                $cost_addition = ($level_2_ops * $y) + ($level_1_ops * $x);
                print "Using Level 2 and Level 1. Cost to adjust $num to $target: $cost_addition\n";
            } else {
                $cost_addition = $diff * $x;
                print "Using only Level 1. Cost to adjust $num to $target: $cost_addition\n";
            }

            $cost += $cost_addition;
        }

        print "Total cost to make all elements $target: $cost\n";
        $min_cost = $cost if $cost < $min_cost;
    }

    return $min_cost;
}

sub max {
    my @array = @_;
    my $max = $array[0];
    foreach (@array) {
        $max = $_ if $_ > $max;
    }
    return $max;
}

sub min {
    my @array = @_;
    my $min = $array[0];
    foreach (@array) {
        $min = $_ if $_ < $min;
    }
    return $min;
}

# Example 1
my @ints1 = (4, 1);
my $x1 = 3;
my $y1 = 2;
print "Minimum cost: " . min_cost_to_equal_elements(\@ints1, $x1, $y1) . "\n";  # Expected Output: 9

# Example 2
my @ints2 = (2, 3, 3, 3, 5);
my $x2 = 2;
my $y2 = 1;
print "Minimum cost: " . min_cost_to_equal_elements(\@ints2, $x2, $y2) . "\n";  # Expected Output: 6
