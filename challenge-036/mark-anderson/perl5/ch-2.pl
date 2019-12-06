#!/usr/bin/env perl
use Modern::Perl             '2018';
use List::Util               'sum';
use Algorithm::Combinatorics 'combinations';

my @indices = (0 .. 4);
my @colors  = qw/R B G Y P/;
my @weights = (1, 1, 2, 12, 4);
my @amounts = (1, 2, 2, 4, 10);
my @answers;

foreach my $k (@indices) {
    my $current_max_amount = 0;
    my @combinations = combinations(\@indices, $k+1);

    foreach my $combination (@combinations) {
        my $colors = join q{}, @colors[$combination->@*];
        my $weight_sum = sum @weights[$combination->@*];
        my $amount_sum = sum @amounts[$combination->@*];

        if($weight_sum <= 15 and $amount_sum > $current_max_amount) {
            $current_max_amount = $amount_sum;
            $answers[$k] = [ $k+1, $colors, $weight_sum, $amount_sum ]; 
        }
    }
}

print <<~HEADER;
    --------------------------------
    Boxes | Colors | Weight | Amount
    --------------------------------
    HEADER

foreach my $answer (@answers) {
    printf "%-8d%-9s%-9d%d\n", $answer->@*;
}

# Output:
# --------------------------------
# Boxes | Colors | Weight | Amount
# --------------------------------
# 1       P        4        10
# 2       BP       5        12
# 3       BGP      7        14
# 4       RBGP     8        15
