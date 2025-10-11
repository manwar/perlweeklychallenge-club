#!/usr/bin/perl
use strict;
use warnings;

sub max_score {
    my ($str) = @_;
    my $max_score = 0;

    my $total_ones = ($str =~ tr/1//);

    my $left_zeros = 0;
    my $right_ones = $total_ones;

    for my $i (0 .. length($str) - 2) {
        my $char = substr($str, $i, 1);
        if ($char eq '0') {
            $left_zeros++;
        } else {
            $right_ones--;
        }
        my $score = $left_zeros + $right_ones;
        $max_score = $score if $score > $max_score;
    }

    return $max_score;
}

my @examples = ("0011", "0000", "1111", "0101", "011101");
foreach my $example (@examples) {
    print "Input: \$str = \"$example\"\n";
    print "Output: ", max_score($example), "\n\n";
}
