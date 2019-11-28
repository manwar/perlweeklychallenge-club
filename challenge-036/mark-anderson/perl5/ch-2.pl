#!/usr/bin/env perl
use Modern::Perl             '2018';
use List::Util               'sum';
use Algorithm::Combinatorics 'combinations';

my @boxes = (
    { Color => 'R', Weight => 1,  Amount => 1  },
    { Color => 'B', Weight => 1,  Amount => 2  },
    { Color => 'G', Weight => 2,  Amount => 2  },
    { Color => 'Y', Weight => 12, Amount => 4  },
    { Color => 'P', Weight => 4,  Amount => 10 }
);

my @answers;

foreach my $k (1 .. 5) {
    my $biggest_sum  = 0;
    my @combinations = combinations(\@boxes, $k);

    foreach my $combination (@combinations) {
        my @colors  = map { $_->{Color}  } $combination->@*;
        my @weights = map { $_->{Weight} } $combination->@*;
        my @amounts = map { $_->{Amount} } $combination->@*;

        my $weight_sum = sum @weights;
        my $amount_sum = sum @amounts;

        if($weight_sum <= 15 and $amount_sum > $biggest_sum) {
            $biggest_sum   = $amount_sum;
            $answers[$k-1] = [$k, (join '', @colors), $weight_sum, $amount_sum]; 
        }
    }
}

say "-" x 42 . "\nNumber Of Boxes | Colors | Weight | Amount\n" . "-" x 42;

foreach my $k (@answers) {
    say sprintf "%-18d%-9s%-9d%d", $k->@*;
}

# Output:
# ------------------------------------------
# Number Of Boxes | Colors | Weight | Amount
# ------------------------------------------
# 1                 P        4        10
# 2                 BP       5        12
# 3                 BGP      7        14
# 4                 RBGP     8        15
