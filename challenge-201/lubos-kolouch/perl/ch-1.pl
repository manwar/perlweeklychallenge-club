use strict;
use warnings;
use Test::More tests => 2;

sub find_missing_numbers {
    my @array = @_;
    my $n = @array;
    my %hash = map { $_ => 1 } @array;
    my @missing_numbers;
    for (my $i=0; $i<=$n; $i++) {
        push @missing_numbers, $i unless exists $hash{$i};
    }
    return @missing_numbers;
}

# test cases
is_deeply([find_missing_numbers(0,1,3)], [2], 'Example 1');
is_deeply([find_missing_numbers(0,1)], [2], 'Example 2');

