#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV >= 2;
usage: $0 [-examples] [-tests] [CODE_F CODE_G ARG ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

CODE_F CODE_G
    bodies of the subs f and g.

ARG...
    Arguments for the call of sub g

Example:
    $0 '(\$_[0]+\$_[1], \$_[0]-\$_[1])' '(\$_[0]*\$_[1], \$_[0]/\$_[1])' 6 2
    prints '15 9' as g(6, 2) = (12, 3) and f(12, 3) = (15, 9).
EOS


### Input and Output

main: {
    # Create sub refs from the code in the first two arguments as sub
    # bodies.
    my @sub = map eval("sub {$_}"), splice @ARGV, 0, 2;

    my $compose = compose(@sub);
    say join ' ', $compose->(@ARGV);

}


### Implementation

sub compose ($f, $g) {
	sub {$f->($g->(@_))};
}


### Examples and tests

sub run_tests {
    my $f = sub ($x, $y) {($x + $y, $x - $y)};
    my $g = sub ($x, $y) {($x * $y, $x / $y)};
    my $h = compose($f, $g);

    SKIP: {
        skip "examples" unless $examples;

        for (1 .. 10) {
            my $x = 1 + int rand 10;
            my $y = 1 + int rand 10;
            # Check random args.
            is $f->($g->($x, $y)), $h->($x, $y), "($x, $y)";
        }
    }

    SKIP: {
        skip "tests" unless $tests;

        is [$h->(6, 2)], [15, 9], '(6, 2) -> (12, 3) -> (15, 9)';
	}

    done_testing;
    exit;
}
