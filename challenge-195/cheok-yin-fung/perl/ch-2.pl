# The Weekly Challenge 195
# Task 2 Most Frequent Even
use v5.30.0;
use warnings;
use List::Util qw/max min/;
sub mfe {
    my @even_list = grep {$_ % 2 == 0} @_;
    return -1 if scalar @even_list == 0;
    my %freq;
    $freq{$_}++ for @even_list;
    my $max = max values %freq;
    return min grep { $freq{$_} == $max } keys %freq;
}

use Test::More tests=>3;
ok mfe(1,1,2,6,2) == 2;
ok mfe(1,3,5,7) == -1;
ok mfe(6,4,4,6,1) == 4;
