#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Gen qw(:utility :iterate :filter);
use Math::Prime::Util 'todigits';
use experimental 'signatures';

our ($examples, $base);
$base ||= 10;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-base=B] [N]

-examples
    run the examples from the challenge
 
-base=B
    find disarium numbers in base B. Default: 10

N
    print the first N disarium numbers in base B.

EOS


### Input and Output

gen_disarium($base)->say(shift);


### Implementation

# Build a streaming (i.e. non-caching) generator for disarium numbers in
# the given base by filtering the sequence of non-negative integers.
# This is certainly not the most efficient implementation as it takes
# several seconds to find the first 19 disarium numbers.
sub gen_disarium ($base) {
    iterate_stream {$_ + 1}->from(0)->filter_stream(
        sub {
            my $p;
            $_ == reduce {$a + $b ** ++$p} 0, todigits $_, $base;
        });
}


### Examples and tests

sub run_tests {

    is gen_disarium(10)->take(19), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 89,
        135, 175, 518, 598, 1306, 1676, 2427, 2646798],
    'task 1, see http://oeis.org/A032799';

    done_testing;
    exit;
}
