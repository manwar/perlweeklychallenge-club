#!/usr/bin/perl -s

use v5.25;
use Test2::V0;
use Graph::Matching 'max_weight_matching';
use Math::Prime::Util 'forcomb';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [NAME...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

NAME...
    list of names

EOS


### Input and Output

print_m(secret_santa(@ARGV));


### Implementation

sub same_family {
    my ($x, $y) = map +(split)[-1], @_;
    $x eq $y;
}

sub secret_santa (@names) {
    return {} if @names % 2;
    my @graph;
    forcomb {push @graph, [@names[@_], 1 - same_family(@names[@_])]} @names, 2;

    +{max_weight_matching(\@graph, 1)};
}

sub print_m {
    my $m = shift;
    say "$_ -> $m->{$_}" for keys %$m;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $m1 = secret_santa('Mr. Wall', 'Mrs. Wall', 'Mr. Anwar',
            'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross');
        subtest 'example 1' => sub {
            plan 6;
            ok !same_family($_, $m1->{$_}), 'different families' for keys %$m1;
        };
        print_m($m1);

        is secret_santa('Mr. Wall', 'Mrs. Wall', 'Mr. Anwar'), {},
        'failed example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        my $m1 = secret_santa('Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', 'A. Wall');
        subtest 'modified example 2' => sub {
            plan 3;
            is scalar %$m1, 4, 'count';
            !same_family($_, $m1->{$_}) && pass 'different families'
                for keys %$m1; 
        };
        print_m($m1);

        my $m2 = secret_santa('1 A', '2 A', '3 A', '1 B', '2 B', '3 B',
            '1 C', '2 C', '3 C', '1 D');
        subtest 'non-trivial case' => sub {
            plan 10;
            ok !same_family($_, $m2->{$_}), 'different families' for keys %$m2;
        };
        print_m($m2);

	}

    done_testing;
    exit;
}
