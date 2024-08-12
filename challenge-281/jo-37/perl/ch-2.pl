#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use Memoize;
use experimental 'signatures';

our ($tests, $examples, $analyze);

run_tests() if $tests || $examples;	# does not return
analyze() if $analyze;              # does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [-analyze] [S E]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-analyze
    calculate some properites

S E
    start and end field coordinates

EOS


### Input and Output

say knights_move(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/08/09/ch-281.html#task-2

use constant N => 8;

BEGIN {
    my $moves = long [0, 1, 0, 1, 0],
                     [1, 0, 0, 0, 1],
                     [0, 0, 0, 0, 0],
                     [1, 0, 0, 0, 1],
                     [0, 1, 0, 1, 0];

    my $adj = zeros long, N, N, N**2;
    $adj->range(identity(N**2)->splitdim(0, N)->whichND - indx(2, 2, 0),
        [5, 5], 't')->reorder(1, 2, 0) .= $moves;
    $adj = $adj->clump(0, 1);

    memoize 'adj', SCALAR_CACHE => 'MERGE';

    sub adj ($n) {
        return identity(N**2) unless $n;
        die "not implemented" if $n < 0;

        adj($n - 1) x $adj;
    }
}

sub knights_move {
    my @fields = map ord() - ord(/\d/ ? '1' : 'a'),
                 map /^([a-h])([1-8])$/, @_;
    die "start and end fields required" unless @fields == 4;

    adj($_)->splitdim(1, N)->splitdim(0, N)->(@fields) &&
        return $_ for 0 .. N**2 - 1;
    'inf';
}

sub diameter {
    my $walks = zeroes adj(0);
    for (0 .. N**2 - 1) {
        $walks += adj($_);
        return $_ if all $walks;
    }
    'inf';
}

sub not_within ($n) {
    my $walks = zeros adj(0);
    $walks += adj($_) for 0 .. $n;
    whichND !$walks->splitdim(1, N)->splitdim(0, N);
}

sub analyze {
    my $diam = diameter();
    say "diameter: $diam";
    say "most distant vertices:", scalar not_within($diam - 1);
    exit;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is knights_move('g2', 'a8'), 4, 'example 1';
        is knights_move('g2', 'h2'), 3, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is knights_move('g6', 'g6'), 0, 'no move';
        is knights_move('a1', 'h8'), 6, 'full diagonal';
        is diameter(), 6, 'diameter';
        is not_within(5)->unpdl,
            bag {
                item [0, 0, 7, 7];
                item [0, 7, 7, 0];
                item [7, 0, 0, 7];
                item [7, 7, 0, 0];
                end;
            }, 'longest paths';
        like dies {knights_move('ab', 'a1', 'h8', '22', 'd5')},
            qr/start and end/, 'invalid args'; 

    }

    done_testing;
    exit;
}
