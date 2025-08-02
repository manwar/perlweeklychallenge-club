use strict;
use warnings;

sub find_integer_appearing_33_percent_or_more {
    my @ints = @_;
    return undef unless @ints;
    
    my %count;
    my $n = scalar @ints;
    my $threshold = $n / 3;
    
    foreach my $int (@ints) {
        $count{$int}++;
    }
    
    my @valid_numbers = grep { $count{$_} >= $threshold } keys %count;
    
    @valid_numbers = sort { $a <=> $b } @valid_numbers;
    
    return $valid_numbers[0] if @valid_numbers;
    return undef;
}

# Test cases
use Test::More tests => 4;

is(find_integer_appearing_33_percent_or_more(1, 2, 3, 3, 3, 3, 4, 2), 3, 'Example 1');
is(find_integer_appearing_33_percent_or_more(1, 1), 1, 'Example 2');
is(find_integer_appearing_33_percent_or_more(1, 2, 3), 1, 'Example 3');
is(find_integer_appearing_33_percent_or_more(), undef, 'Empty list');

done_testing();
