#!/usr/bin/perl
use v5.38;
use warnings;

use List::Util qw(sum0 first);
use Iterator::Simple qw(iterator ienumerate);

# Select which implementation to use
impl_3();

sub impl_1 {
    my @ints = @ARGV;
    my @left_right_sums = left_right_sums(@ints);
    my $middle_index = (first {
        my $left_right_sum = $left_right_sums[$_];
        $left_right_sum->[0] == $left_right_sum->[1]
    } 0 .. $#ints) // -1;
    say $middle_index;
}

sub impl_2 {
    say middle_index(@ARGV);
}

sub impl_3 {
    my @ints = @ARGV;
    my $iter = ienumerate(left_right_sums_iter(@ints));
    while (my $enumerated_item = $iter->()) {
        my ($i, $left_right_sum) = @$enumerated_item;
        if ($left_right_sum->[0] == $left_right_sum->[1]) {
            say $i;
            return;
        }
    }
    say -1;
}

sub left_right_sums {
    my @left_right_sums;
    my $total_sum = sum0(@_);
    my $left_sum = 0;
    for my $item (@_) {
        my $right_sum = $total_sum - $left_sum - $item;
        push @left_right_sums, [ $left_sum, $right_sum ];
        $left_sum += $item;
    }
    return @left_right_sums;
}

sub left_right_sums_iter {
    my @ints = @_;
    my $total_sum = sum0(@_);
    my $left_sum = 0;
    my $i = 0;
    iterator {
        return if $i > $#ints;
        my $item = $ints[$i];
        my $right_sum = $total_sum - $left_sum - $item;
        my $left_right_sum = [ $left_sum, $right_sum ];
        $left_sum += $item;
        $i++;
        return $left_right_sum;
    }
}

sub middle_index {
    my @ints = @_;
    my $total_sum = sum0(@ints);
    my $left_sum = 0;
    for my $i (0 .. $#ints) {
        my $item = $ints[$i];
        my $right_sum = $total_sum - $left_sum - $item;
        return $i if $left_sum == $right_sum;
        $left_sum += $item;
    }
    return -1;
}

__END__
