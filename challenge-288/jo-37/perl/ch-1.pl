#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    integer

EOS


### Input and Output

say closest_palindrome(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/09/27/ch-288.html#task-1


sub near_palindrome ($n, $d) {
    my $odd = length($n) % 2;
    my $head = substr $n, 0, (length($n) + $odd) / 2;
    my $l0 = length $head;
    $head += $d;
    if (!$head || $l0 != length $head) {
        $head = $head * 10 + 9 if $d < 0 && !$odd;
        $head /= 10 if $d > 0 && $odd;
        $odd ^= !!$head;
    }

    $head . reverse($odd ? substr $head, 0, -1 : $head);
}

sub closest_palindrome ($n) {
    return 0 + !$n if ($n += 0) < 1;
    my $p0 = near_palindrome($n, 0);
    my $lo = $p0 < $n ? $p0 : near_palindrome($n, -1);
    my $hi = $p0 > $n ? $p0 : near_palindrome($n, 1);

    $lo + $hi >= 2 * $n ? $lo : $hi;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is closest_palindrome(123), 121, 'example 1';
        is closest_palindrome(2), 1, 'example 2';
        is closest_palindrome(1400), 1441, 'example 3';
        is closest_palindrome(1001), 999, 'example 4';


    }

    SKIP: {
        skip "tests" unless $tests;

        is near_palindrome(9, 1), 11, '9->11';
        is near_palindrome(10, -1), 9, '10->9';
        is near_palindrome(10, 0), 11, '10->11';
        is near_palindrome(99, 1), 101, '99->101';
        is near_palindrome(100, -1), 99, '100->99';
        is near_palindrome(100, 0), 101, '100->101';
        is near_palindrome(999, 1), 1001, '999->1001';
        is near_palindrome(1000, -1), 999, '1000->999';
        is near_palindrome(1000, 0), 1001, '1000->1001';

        is near_palindrome(12345, -1), 12221, 'lower odd';
        is near_palindrome(12345, 0), 12321, 'mid odd';
        is near_palindrome(12345, 1), 12421, 'upper odd';
        is near_palindrome(1234, -1), 1111, 'lower even';
        is near_palindrome(1234, 0), 1221, 'mid even';
        is near_palindrome(1234, 1), 1331, 'upper even';
        


        is closest_palindrome(12370), 12321, 'odd, pick lower';
        is closest_palindrome(12371), 12321, 'odd, pick lower from equal';
        is closest_palindrome(12372), 12421, 'odd, pick higher';

        is closest_palindrome(1275), 1221, 'even, pick lower';
        is closest_palindrome(1276), 1221, 'even, pick lower from equal';
        is closest_palindrome(1277), 1331, 'even, pick higher';

        is closest_palindrome(-1), 0, 'negative';
        is closest_palindrome(0), 1, 'zero';
        is closest_palindrome(1), 0, 'one';
        
    }

    done_testing;
    exit;
}
