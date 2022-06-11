#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!array';
use bigint;
use List::Gen qw(:iterate :zip :source);
use List::Util qw(product);
use Math::Prime::Util qw(is_prime gcd);
use experimental qw(signatures postderef);

our ($tests, $examples, $iv, $f);
$iv ||= '3, 0, 2';
$f ||= '1, 1';

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-f=F1,...,Fl] [-iv=S1,...Sk] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-f=F1,...,Fl
    Coefficients for the linear recurrence relation.

-iv=S1,...,Sk
    Starting values for the generated sequence.

N
    Print the first N prime numbers from the generated sequence.

    The sequence starts with the values S1,...,Sk and has the
    linear recurrence relation:
    S(n) = F(1) * S(n - k) + ... + F(k) * S(n - 1) for n > k.
    Selecting unique primes from this sequence.

Some known prime sequences:
IV=0,1   F=1,1: Fibonacci
IV=2,1   F=1,1: Lucas
IV=1,1,1 F=1,1: Padovan
IV=3,0,2 F=1,1: Perrin (default)
IV=0,1   F=1,2: Pell
IV=0,1   F=2,1: Jacobsthal

CAUTION: Improper choice of IV and F will cause an endless loop!

EOS


### Input and Output

main: {
    # Explicit conversion to Math::BigInt is required for a set of
    # variables so that all newly generated values inherit therefrom.
    # Linear factors:
    my $f = [map Math::BigInt->new($_), split /, */, $f];
    # Initial values:
    my $iv = [split /, */, $iv];

    # "say(n)" prints the first n generated elements.
    lin_recur_primes($iv, $f)->say(shift);
}


### Implementation

# The solution to task 2 from challenge 154 with different starting
# values could be reused to solve this task.  But this would by boring
# and thus the task will be generalized here.
#
# The excellent Math::Prime::Util ennobles List::Gen by referencing it in
# the "SEE ALSO" section.  Indeed, it looks very cool but comes with a
# serious flaw: There has not been any development for over 10 years and
# one of the tests is broken.  Needed "--force" to install. IMHO the
# test result is ok, but the expected outcome is not.
# "Failed test 'map & \(1 .. 3), 1 .. 2'"
#
# Building a generator for a sequence having the initial values
# S(1),...,S(k) and a recurrence relation defined by a linear
# combination of preceding elements:
# S(n) = F(1) * S(n - k) + ... + F(k) * S(n - 1) for n > k.
# and taking unique primes thereof.
#
sub lin_recur_primes ($s, $f) {

    # Lazily extend the initial sequence using the recurrence relation.
    ($s + iterate {($s = [$s->@[1 .. $#$s],
                    tuples($f, $s)->map('product @$_')->sum])->[-1]
        })->uniq->filter(sub {is_prime $_});
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        # "take" returns the given number of elements.
        is lin_recur_primes([3, 0, 2], [1, 1])->take(13),
        [3, 2, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193,
            792606555396977], 'task 1';
    }

    SKIP: {
        skip "tests" unless $tests;

        # "get" accesses elements by a zero-based index.  Thus "get(15)"
        # is *three* behind the last from "take(13)".
        is lin_recur_primes([3, 0, 2], [1, 1])->get(15),
        '22584751787583336797527561822649328254745329',
        'Perrin prime from http://oeis.org/A074788';

        is lin_recur_primes([0, 1], [1, 1])->take(11),
        [2, 3, 5, 13, 89, 233, 1597, 28657, 514229, 433494437,
            2971215073],
            'Fibonacci primes from Wiki';

        is lin_recur_primes([1, 1, 1], [1, 1])->take(12),
        [2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057,
            1363005552434666078217421284621279933627102780881053358473,
            1558877695141608507751098941899265975115403618621811951868598809164180630185566719],
            'Padovan primes from Wiki';
        
        is lin_recur_primes([2, 1], [1, 1])->take(15),
        [2, 3, 7, 11, 29, 47, 199, 521, 2207, 3571, 9349, 3010349,
            54018521, 370248451, 6643838879],
            'Lucas primes from Wiki';

        is lin_recur_primes([3, 1], [1, 1])->take(20),
        [3, 5, 23, 37, 97, 157, 1741, 11933, 50549, 214129, 560597,
            16276621, 180510493, 398386576261, 1042989597313,
            41305516996050613, 174972977841043309, 13300248193487978669,
            238663270054423392193, 624828552868675407173],
            'A091157';

        is lin_recur_primes([0, 1], [1, 2])->take(8),
        [2, 5, 29, 5741, 33461, 44560482149, 1746860020068409,
            68480406462161287469],
            'Pell primes from Wiki';

        is lin_recur_primes([0, 1], [2, 1])->take(15),
        [3, 5, 11, 43, 683, 2731, 43691, 174763, 2796203, 715827883,
            2932031007403, 768614336404564651, 201487636602438195784363,
            845100400152152934331135470251,
            56713727820156410577229101238628035243],
            'Jacobsthal primes from Wiki';
	}

    done_testing;
    exit;
}
