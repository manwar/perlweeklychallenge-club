use strict;
use warnings;

sub longest_arithmetic_subsequence {
    my @ints = @_;
    my %dp;
    my $max_length = 2;    # minimal length of arithmetic subsequence is 2

    for my $i ( 1 .. $#ints ) {
        for my $j ( 0 .. $i - 1 ) {
            my $diff = $ints[$i] - $ints[$j];
            $dp{$i}{$diff} = ( exists $dp{$j}{$diff} ? $dp{$j}{$diff} : 1 ) + 1;
            $max_length = $dp{$i}{$diff} if $dp{$i}{$diff} > $max_length;
        }
    }

    return $max_length;
}

my @ints = ( 9, 4, 7, 2, 10 );
print longest_arithmetic_subsequence(@ints), "\n";    # Output: 3

@ints = ( 3, 6, 9, 12 );
print longest_arithmetic_subsequence(@ints), "\n";    # Output: 4

@ints = ( 20, 1, 15, 3, 10, 5, 8 );
print longest_arithmetic_subsequence(@ints), "\n";    # Output: 4
