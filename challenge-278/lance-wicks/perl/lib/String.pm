package String;

use strict;
use warnings;


use feature qw(signatures);
no warnings qw(experimental::signatures);

use Data::Dumper;

sub num_sort ( $class, $string ) {
    my @words = split " ", $string;

    my %word_order;
    for my $item (@words) {
        $item =~ m/^(\w+)(\d+)$/;
        $word_order{$2} = $1;
    }

    my @words_in_order;
    for my $item ( sort keys %word_order ) {
        push @words_in_order, $word_order{$item};
    }

    return join ' ', @words_in_order;
}

1;