use strict;
use warnings;

use v5.38;

use List::Util qw( max );

my @inputs = (
    [1, 2, 2, 4, 1, 5],
    [1, 2, 3, 4, 5]
    );
for (@inputs) {
    my @input = @$_;
    say join (", ", @input) . " =max freq count=> " . max_freq_count( @input );
}

sub max_freq_count( @list ){
    my %counts;
    map { ++$counts{ $_ } } @list;
    my $max_count = max values %counts;
    return $max_count * scalar grep { $_ == $max_count } values %counts;
}
