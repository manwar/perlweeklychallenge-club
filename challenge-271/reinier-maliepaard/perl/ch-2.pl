#!/usr/bin/perl
use strict;
use warnings;

# function to count the number of 1 bits in the binary representation
sub count_ones {
    return(my $count = sprintf("%b", @_) =~ tr/1//);
}

sub count_sort_1_bits {
    my @numbers = @_;

    # count the number of 1 bits for each number and save to %hash
    my %hash;
    foreach my $number (@numbers) {
        my $ones_count = count_ones($number);
        $hash{$number} = $ones_count;
    }

    # sort keys by their values in ascending order
    my @sorted_keys_asc = sort( { $hash{$a} <=> $hash{$b} or $a <=> $b } (sort keys %hash) );

    # join for the right output
    print("(", join(", ", @sorted_keys_asc), ")\n");
}

# TESTS
my @numbers = (0, 1, 2, 3, 4, 5, 6, 7, 8);
count_sort_1_bits(@numbers); # Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)

@numbers = (1024, 512, 256, 128, 64);
count_sort_1_bits(@numbers); # Output: (64, 128, 256, 512, 1024)

@numbers = (7, 23, 512, 256, 128, 64);
count_sort_1_bits(@numbers); # Output: (64, 128, 256, 512, 7, 23)

