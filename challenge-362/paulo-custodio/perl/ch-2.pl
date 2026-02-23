#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
my @nums =
        map {$_->[0]}
        sort {$a->[1] cmp $b->[1]}
        map {[$_, number_to_text($_)]} @ARGV;
say "(", join(", ", @nums), ")";


sub number_to_text {
    my($num) = @_;
    return join(" ", number_to_text1($num));
}

sub number_to_text1 {
    my($num) = @_;
    my @output;

    if ($num == 0) {
        return ("zero");
    }

    if ($num < 0) {
        return ("minus", number_to_text1(-$num));
    }

    my @orders = (
        [1000000, "milion"],
        [1000, "thousand"],
        [100, "hundred"],
    );

    for (@orders) {
        my($bracket, $text) = @$_;
        if ($num == $bracket) {
            return (number_to_text1(int($num / $bracket)), $text);
        }
        if ($num >= $bracket) {
            return (number_to_text1(int($num / $bracket)), $text, number_to_text1($num % $bracket));
        }
    }

    my @classes = (
        [90, "ninety"],
        [80, "eighty"],
        [70, "seventy"],
        [60, "sixty"],
        [50, "fifty"],
        [40, "forty"],
        [30, "thirty"],
        [20, "twenty"],
        [19, "nineteen"],
        [18, "eighteen"],
        [17, "seventeen"],
        [16, "sixteen"],
        [15, "fifteen"],
        [14, "fourteen"],
        [13, "thirteen"],
        [12, "twelve"],
        [11, "eleven"],
        [10, "ten"],
        [9, "nine"],
        [8, "eight"],
        [7, "seven"],
        [6, "six"],
        [5, "five"],
        [4, "four"],
        [3, "three"],
        [2, "two"],
        [1, "one"],
    );

    for (@classes) {
        my($bracket, $text) = @$_;
        if ($num == $bracket) {
            return ($text);
        }
        elsif ($num >= $bracket) {
            return ($text, number_to_text1($num - $bracket));
        }
    }

    die "not reached";
}
