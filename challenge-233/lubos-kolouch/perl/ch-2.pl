use strict;
use warnings;
use Test::More;

sub frequency_sort {
    my @ints = @_;
    
    # Count frequencies
    my %frequency;
    $frequency{$_}++ for @ints;
    
    # Custom sort
    my @sorted = sort {
        $frequency{$a} <=> $frequency{$b} || $b <=> $a
    } @ints;

    return @sorted;
}

# Testing the Perl solution
is_deeply([frequency_sort(1,1,2,2,2,3)], [3,1,1,2,2,2], 'Test Case 1');
is_deeply([frequency_sort(2,3,1,3,2)], [1,3,3,2,2], 'Test Case 2');
is_deeply([frequency_sort(-1,1,-6,4,5,-6,1,4,1)], [5,-1,4,4,-6,-6,1,1,1], 'Test Case 3');

done_testing();

