package main;

use strict;
use warnings;

use List::Util qw(min);

print max_of_min_pairs([1,2,3,4]) . "\n";
print max_of_min_pairs([0,2,1,3]) . "\n";

sub max_of_min_pairs
{
    my($numbers_aref) = @_;

    my $max_sum = 0;

    my %unique_pairs = find_unique_pairs($numbers_aref);

    my @unique_pairs = values %unique_pairs;

    for(my $i = 0; $i < scalar(@unique_pairs); $i++) {
        for(my $j = 0; $j < scalar(@unique_pairs); $j++) {
            # do not compare a pair to itself,
            if($i == $j) {
                next;
            }

            if(!pairs_have_unique_elements($unique_pairs[$i], $unique_pairs[$j])) {
                next;
            }

            my $sum = min(@{$unique_pairs[$i]}) + min(@{$unique_pairs[$j]});

            if($sum > $max_sum) {
                $max_sum = $sum;
           }
        }
    }

    return $max_sum;
}

sub find_unique_pairs
{
    my($numbers_aref) = @_;

    my %unique_pairs = ();

    for(my $i = 0; $i < scalar(@{$numbers_aref}); $i++) {
       for(my $j = 0; $j < scalar(@${numbers_aref}); $j++){
           if($i == $j) {
                next;
           }

           my (@numbers_in_pair) = ($numbers_aref->[$i], $numbers_aref->[$j]);
           my $pair_key = join(':', sort { $a <=> $b } @numbers_in_pair);

            if(! exists $unique_pairs{$pair_key}) {
                $unique_pairs{$pair_key} = \@numbers_in_pair;
            }
        }
    }

    return %unique_pairs;
}

sub pairs_have_unique_elements
{
    my($element_a, $element_b) = @_;

    foreach my $number_a (@{$element_a}) {
        foreach my $number_b (@{$element_b} ) {
            if($number_b == $number_a) {
                return 0;
            }
        }
    }

    return 1;
}

1;

