#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental qw(signatures postderef);
use Syntax::Keyword::Gather;
use Parallel::Subs;
use Math::Prime::Util 'is_square';

our ($tests, $examples, $long);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-long] [L]

-examples
    run the examples from the challenge. (This will take several seconds
    or even longer to complete - depending on the hardware.)
 
-tests
    run some tests

-long
    enable long running tasks (L > 9)

L
    number of decimal digits

EOS


### Input and Output

die "use '-long' to enable long running task" if $ARGV[0] > 9 && !$long;
say $_ for rare_nums_len($ARGV[0]);


### Implementation

# Create a map from the last digit Q to the possible second last digits
# P for given starting digits A and B.
sub q2p ($a, $b) {
    if ($a == 2) {
        return {
            2 => [$b * 10],
        }
    }
    if ($a == 4) {
        return {
            0 => $b % 2 ? [10, 30, 50, 70, 90] : [0, 20, 40, 60, 80],
        }
    }
    if ($a == 6) {
        my $p = $b % 2 ? [0, 20, 40, 60, 80] : [10, 30, 50, 70, 90];
        return {
            0 => $p,
            5 => $p,
        }
    }
    if ($a == 8) {
        return {
            2 => [(9 - $b) * 10],
            3 => [(($b - 7) % 10) * 10],
            7 => [((11 - $b) % 10) * 10],
            8 => [$b * 10],
        }
    }
}

# Collect all rare numbers in interval [$low, $high).
# $low must be a multiple of 100.  All numbers less than $high must have
# the same first digit as $low.
# Blindly following the rules for the first two and last two digits from
# the defining web page.
sub rare_nums_in ($low, $high, $opt=1) {
    use integer;
    my ($n, $r, $b, $p, $q, %p, @rare);
    my $a = substr $low, 0, 1;
    my @q = sort keys %{q2p($a, 0)};
    my $b_prev = -1;
    for (my $n00 = $low; $n00 < $high; $n00 += 100) {
        $b = substr $n00, 1, 1;
        if ($b != $b_prev) {
            %p = %{q2p($a, $b)};
            $b_prev = $b;
        }
        for $q (@q) {
            for $p ($p{$q}->@*) {
                push @rare, $n if
                    ($n, $r) = ($n00 + $p + $q, scalar reverse $n00 + $p + $q),
                    is_square($n + $r) &&
                    is_square($n - $r);
            }
        }
    }

    \@rare;
}

# Divide search into subtasks.
# Calculate lower and upper limit for individual sub tasks.  The limits
# are alway a multiple of 100 and all numbers smaller than the upper
# limit have the same first digit as the lower limit.
# Generate list of [$lower, $upper]
sub split_task ($len) {

    my $numcpu = Sys::Info->new->device('CPU')->count;
    my $size = 10 ** ($len-1) / $numcpu;

    gather {
        for my $lead (2, 4, 6, 8) {
            my $start = $lead * 10 ** ($len-1);
            for my $s (1 .. $numcpu) {
                take [int(($start + int(($s - 1) * $size)) / 100) * 100,
                    int(($start + int($s * $size)) / 100) * 100];
            }
        }
    };
}

# Collect all rare numbers having $l decimal digits.  The task is
# separated into several sub tasks that are executed in parallel on available
# cpu cores.
sub rare_nums_len ($len) {
    # Fake small results as the optimized loop operates on four digits.
    return 65 if $len == 2;
    return () if $len == 3;

    my $p = Parallel::Subs->new;
    for my $lim (split_task($len)) {
        $p->add(sub{rare_nums_in($lim->[0], $lim->[1])});
    }
    $p->wait_for_all;

    grep {reverse() != $_} map $_->@*, $p->results->@*;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [rare_nums_len 2], [65], 'example a, faked';
        is [rare_nums_len 6], [621770], 'example b';
        is [rare_nums_len 9], [281089082], 'example c';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [rare_nums_len 4], [], 'len 4';
        is [rare_nums_len 5], [], 'len 5';
        is [rare_nums_len 7], [], 'len 7';
        is [rare_nums_len 8], [], 'len 8';

	}

    done_testing;
    exit;
}
