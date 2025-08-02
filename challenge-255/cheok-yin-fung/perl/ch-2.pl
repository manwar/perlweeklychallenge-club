# The Weekly Challenge 255
# Task 2 Most Frequent Word
use v5.30.0;
use warnings;
use List::Util qw/max/;
use List::MoreUtils qw/frequency/;

sub mfw {
    my $p = $_[0];
    my $w = $_[1];
    my @arr = split /\W+/, $p;
    my %freq = frequency @arr;
    my $c = 1;
    my @max_freq_word;
    while ($c) {
        my $max_freq = max values %freq;
        @max_freq_word = grep {$freq{$_} == $max_freq} keys %freq;
        @max_freq_word = grep {$_ ne $w} @max_freq_word;
        if (scalar @max_freq_word == 0) {
            $freq{$w} = 0;
        }
        else {
            $c = 0;
        }
    }
    return $max_freq_word[0] if scalar @max_freq_word == 1;
    return [@max_freq_word];
}

use Test2::V0;
is mfw(
    "Joe hit a ball, the hit ball flew far after it was hit.",
    "hit"
), "ball";
is mfw(
    "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.",
    "the"
), "Perl";
done_testing;
