#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use AnyEvent;
use Coro;
use Coro::AnyEvent;

use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [I1 I2 ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

I1 I2 ...
    nonnegative integers to be sorted

EOS


### Input and Output

say "@{sleep_sort(\@ARGV)}";


### Implementation

# Coros, as cooperative threads, generally do not run in parallel, thus
# no locking is required when accessing shared data.  Using a semaphore
# for flow control: by waiting for the "ready" semaphore to become
# available, the main thread allows the async coros to be scheduled and
# regains control when all have finished with the same call.
# Note: The sleep function is event-driven and will not block the
# overall processing.
sub sleep_sort ($arr) {
    # Collect sorted result here:
    my @sorted;
    # Will be unlocked when all threads have finished:
    my $ready = Coro::Semaphore->new(1 - @$arr);
    # Create threads.
    async {
        my ($ready, $sorted, $time) = @_;
        die "time machine not implemented" if $time < 0;
        say "sleep for $time s" if $verbose;
        Coro::AnyEvent::sleep $time;
        say "woke up after $time s" if $verbose;
        push @$sorted, $time;
        $ready->up;
    } $ready, \@sorted, $_ for @$arr;
    # Start processing and wait for async threads.
    $ready->down;

    \@sorted;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples";
    }

    SKIP: {
        skip "tests" unless $tests;
        is sleep_sort([3, 1, 2, 1]), [1, 1, 2, 3], 'simple test';

        local $verbose;
        is sleep_sort([2, (1) x 9999]),
            array {item 9999 => 2; etc;}, 'check last element';
    }

    done_testing;
    exit;
}
