#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 168 Task 1  Perrin Prime
#=============================================================================
# The Perrin sequence is defined to start with [3, 0, 2]; after that, term
# N is the sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ….)
# A Perrin prime is a number in the Perrin sequence which is also a prime number.
# Calculate the first 13 Perrin Primes.
# f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977]
#=============================================================================

use v5.42;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================
use feature 'class'; no warnings 'experimental::class';

class Perrin { 
    field @perrin = ( '_', 3, 0, 2 );
    field $n :reader(get_n) = 1;

    method next() {
        if ( $n < 4 ) { return $perrin[$n++] }
        else {
            push @perrin, ($perrin[-2] + $perrin[-3]);
            return $perrin[-1];
        }
    }


    method sequence() { [ @perrin ] }
}

#=============================================================================

exit(!runTest()) if $DoTest;

say perrinPrime($_) for @ARGV;

#=============================================================================
sub perrinPrime($n)
{
    use Math::Prime::Util qw/is_prime/;

    my $perrin = Perrin->new();

    my %prime = ( 2 => 1, 3 => 1 );
    while ( keys %prime < $n )
    {
        my $p = $perrin->next();
        if ( is_prime($p) )
        {
            $logger->debug("$p is prime at ", $perrin->get_n() );
            $prime{$p}++;
        }
    }

    my @pp = sort { $a <=> $b} keys %prime;
    return [ @pp[0..$n-1] ];
}


sub runTest
{
    use Test2::V0;

    my $p = Perrin->new();
    is( $p->next(), 3, 'p(1)');
    is( $p->next(), 0, 'p(2)');
    is( $p->next(), 2, 'p(3)');
    is( $p->next(), 3, 'p(4)');
    is( $p->next(), 2, 'p(5)');
    is( $p->next(), 5, 'p(6)');
    is( $p->next(), 5, 'p(7)');
    is( $p->next(), 7, 'p(8)');

    is( perrinPrime(1), [2      ], 'prime(1)');
    is( perrinPrime(2), [2,3    ], 'prime(2)');
    is( perrinPrime(3), [2,3,5  ], 'prime(3)');
    is( perrinPrime(4), [2,3,5,7], 'prime(4)');

    is( perrinPrime(13), [ 2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721,
                         1442968193, 792606555396977 ], "p(13)");

    done_testing;
}
