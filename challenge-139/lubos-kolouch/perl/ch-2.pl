use strict;
use warnings;
use bignum ( p => -100 );
use Math::Prime::Util qw/next_prime/;

sub get_repeating_pattern {
    my $what = shift;

    my $big_reverse = 1 / $what;
    my $repeating   = $1 if ($big_reverse) =~ /(.+?)\1/msx;

    return length($repeating);
}

sub is_long_prime {
    my $what = shift;

    my $repeats = get_repeating_pattern($what);

    return 1 if ( $repeats > 1 ) and ( $repeats == $what - 1 );

    return 0;
}

sub generate_long_primes {

    my $primes_count = 0;
    my $at_prime     = 0;

    my @result;

    while ( $primes_count < 5 ) {
        $at_prime = next_prime($at_prime);

        if ( is_long_prime($at_prime) ) {
            $primes_count++;
            push @result, $at_prime;
        }
    }

    return \@result;
}

use Test::More;

is( get_repeating_pattern(7),  6 );
is( get_repeating_pattern(17), 16 );

is( is_long_prime(7),  1 );
is( is_long_prime(17), 1 );
is( is_long_prime(2),  0 );
is_deeply( generate_long_primes(), [ 7, 17, 19, 23, 29 ] );

done_testing;
