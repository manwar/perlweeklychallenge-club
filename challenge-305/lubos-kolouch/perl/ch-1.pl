use strict;
use warnings;
use Test::More;

sub is_prime {
    my ($n) = @_;
    return 0 if $n <= 1;
    return 1 if $n == 2;
    return 0 if $n % 2 == 0;
    for ( my $i = 3 ; $i <= sqrt($n) ; $i += 2 ) {
        return 0 if $n % $i == 0;
    }
    return 1;
}

sub binary_prefix {
    my @binary = @_;
    my @result;
    my $current_num = 0;
    foreach my $bit (@binary) {
        $current_num = $current_num * 2 + $bit;
        push @result, is_prime($current_num) ? 1 : 0;
    }
    return @result;
}

# Test cases
is_deeply( [ binary_prefix( 1, 0, 1 ) ], [ 0, 1, 1 ], 'Example 1' );
is_deeply( [ binary_prefix( 1, 1, 0 ) ], [ 0, 1, 0 ], 'Example 2' );
my @input3    = ( 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1 );
my @expected3 = ( 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 );
is_deeply( [ binary_prefix(@input3) ], \@expected3, 'Example 3' );

# Edge cases
is_deeply( [ binary_prefix(0) ],         [0],         'Edge case single 0' );
is_deeply( [ binary_prefix(1) ],         [0],         'Edge case single 1' );
is_deeply( [ binary_prefix( 0, 0, 0 ) ], [ 0, 0, 0 ], 'All zeros' );
is_deeply( [ binary_prefix( 1, 0 ) ],    [ 0, 1 ],    '1,0' );

done_testing();
