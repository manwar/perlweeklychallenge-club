#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    'abcdbca',
    'cdeabeabfcdfabgcd',
);

for my $e (@examples) {
    my $output = most_frequent_letter_pair($e);

    say <<~"END";
    Input:  \$input = '$e'
    Output:          '$output'
    END
}

sub most_frequent_letter_pair ($string) {
    my %data;
    for my $i ( 0 .. -2 + length $string ) {
        my $sub = substr $string, $i, 2;
        $data{$sub}++;
    }
    # ($scalar) = @list will assign the first element in the list to $scalar
    my ($first) = sort { $data{$b} <=> $data{$a} }  # second sort on value
        sort keys %data;                            # first sort on lexographic value
    return $first;
}
