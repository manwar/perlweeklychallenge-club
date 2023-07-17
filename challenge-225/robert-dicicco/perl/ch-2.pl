#!/usr/bin/env perl
=begin comment
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-11
Challenge 225 Task 2 Left Right Sum Diff ( Perl )
---------------------------------------
=cut
use strict;
use warnings;
use feature 'say';

my @array = (1, 2, 3, 4, 5);
my @left = ();
my @right = ();
my @left_right_sum_diff = ();

sub ltr {
    my @array = @_;
    my $sum = 0;

    push @left, 0;
    for my $i (0 .. $#array - 1) {
        $sum += $array[$i];
        push @left, $sum;
    }
}

sub rtl {
    my @array = @_;
    my $sum = 0;
    push @right, 0;
    for ( my $i = $#array; $i > 0; $i--) {
        $sum += $array[$i];
        push @right, $sum;
    }
}

say ("Input:  \@ints = (@array)");
ltr(@array);

print("\t\@left = ");
print join(", ", @left), "\n";

rtl(@array);
print("\t\@right = ");
@right = reverse(@right);
print join(", ", @right), "\n";

for my $i (0 .. $#array) {
    push @left_right_sum_diff, abs($left[$i] - $right[$i]);
}

my $str = join(", ", @left_right_sum_diff, "\n");
substr($str, -3) = '';
print("\tOutput: \@left_right_sum_diff = $str\n");

=begin comment
---------------------------------------
SAMPLE OUTPUT
perl LRSD.pl
Input:  @ints = (10 4 8 3)
        @left = 0, 10, 14, 22
        @right = 15, 11, 3, 0
        Output: @left_right_sum_diff = 15, 1, 11, 22

perl LRSD.pll
Input:  @ints = (1 2 3 4 5)
        @left = 0, 1, 3, 6, 10
        @right = 14, 12, 9, 5, 0
        Output: @left_right_sum_diff = 14, 11, 6, 1, 10
---------------------------------------
=cut



