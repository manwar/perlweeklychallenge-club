use strict;
use warnings;
use Test::More;

sub is_prime {
    my $num = shift;
    return 0 if $num < 2;
    for my $i ( 2 .. sqrt($num) ) {
        return 0 if $num % $i == 0;
    }
    return 1;
}

sub prime_count {
    my $n = shift;
    return scalar grep { is_prime($_) } ( 1 .. $n - 1 );
}

# Test cases
is( prime_count(10), 4, 'Test Case 1' );
is( prime_count(15), 6, 'Test Case 2' );
is( prime_count(1),  0, 'Test Case 3' );
is( prime_count(25), 9, 'Test Case 4' );

done_testing();
