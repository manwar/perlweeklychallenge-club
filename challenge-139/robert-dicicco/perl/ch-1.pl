#! perl.exe

## Author: Robert DiCicco
## Date: 17-NOV-2021
## Challenge 139 Long Primes

use strict;
use warnings;
use ntheory qw/divisors powmod is_prime/;
use 5.30.0;

my $cnt        = 0;
my $test_prime = 1;

print("Enter the number of primes to find : ");

my $limit = <STDIN>;
chomp($limit);

print("Finding $limit Long Primes\n");
while ( 1 == 1 ) {
    my $ret = long_prime($test_prime);
    if ( $ret > 0 ) {
        $cnt++;
        print("$cnt. $test_prime\n");
        if ( $cnt == $limit ) {
            say "Goodbye !";
            last;
        }
    }

    $test_prime++;
}

sub long_prime {
    my ($p) = @_;
    return 0 unless is_prime($p);

    for my $d ( divisors( $p - 1 ) ) {
        return $d + 1 == $p if powmod( 10, $d, $p ) == 1;
    }

    return (0);
}
