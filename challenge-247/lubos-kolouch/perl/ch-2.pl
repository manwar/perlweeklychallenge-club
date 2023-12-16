use strict;
use warnings;
use Test::More tests => 2;

sub most_frequent_letter_pair {
    my ($s) = @_;
    my %pairs;

    # Counting frequencies of each pair
    $pairs{ substr( $s, $_, 2 ) }++ for 0 .. length($s) - 2;

    # Finding the most frequent pair
    my @sorted_pairs = sort { $pairs{$b} <=> $pairs{$a} || $a cmp $b } keys %pairs;
    return $sorted_pairs[0];
}

# Tests
is( most_frequent_letter_pair('abcdbca'),           'bc', 'Example 1' );
is( most_frequent_letter_pair('cdeabeabfcdfabgcd'), 'ab', 'Example 2' );
